Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUDQP1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 11:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbUDQP1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 11:27:45 -0400
Received: from mail.maicasco.hu ([195.56.119.225]:36874 "EHLO mail.maicasco.hu")
	by vger.kernel.org with ESMTP id S263942AbUDQP1m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 11:27:42 -0400
Message-ID: <40814CEA.7040706@mai-cee.com>
Date: Sat, 17 Apr 2004 17:27:38 +0200
From: =?ISO-8859-2?Q?V=E1g=E1si_L=E1szl=F3?= <l.vagasi@mai-cee.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; hu-HU; rv:1.5) Gecko/20031007
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Error compiling kernel 2.6.4 with dpt_i2o driver
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

My company is running a Degian GNU Linux on a dual Intel PII 933MHz 
system with 1 GB RAM.
Currently it is running kernel 2.4.22 which supports our Adaptec 2100S 
raid controller using the dpt_i2o driver.

We decided to change to kernel 2.6.x (I have tried 2.6.0, 2.6.1, 2.6.4) 
but it fails to compile.
Here are some lines from the output:

drivers/scsi/dpt_i2o.c:32:2 #error Please convert me to 
Documentation/DMA-mapping.txt
drivers/scsi/dpt_i2o.c: In function 'adpt_install_hba':
drivers/scsi/dpt_i2o.c:997: warning: passing arg 2 of 'request_irq' from 
incompatible pointer type
drivers/scsi/dpt_i2o.c: I function 'adpt_scsi_to_i25':
drivers/scsi/dpt_i2o.c:2118: structure has no member named 'address'
drivers/scsi/dpt_i2o.c: At top level:
drivers/scsi/dpt_i2o.c:165: warning: 'dptids' defined but not used

Is it a bug in the kernel source or I have miss configured something?

Here is the result of the ver_linux script:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux szamoca 2.4.22 #6 SMP Mon Oct 6 13:27:22 CEST 2003 i686 unknown
 
Gnu C                  3.0.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      0.9.15-pre4
e2fsprogs              1.27
quota-tools            3.04.
PPP                    2.4.1
nfs-utils              1.0
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         st


If You need any other information I'll send it.

Thanks for Your help.

László

-- 
Vágási László

MAI CASCO Biztosítási Szolgáltató Kft.
1062 Budapest Bajza utca 19.
Tel: +36  1 413 2360
Fax: +36  1 461 0462
Mob: +36 20 967 9858
E-mail: l.vagasi@mai-cee.com
www.mai-cee.com



