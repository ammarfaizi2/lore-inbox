Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbTLLBYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 20:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTLLBYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 20:24:43 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:32236 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264409AbTLLBYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 20:24:41 -0500
Message-ID: <3FD918D8.7020100@verizon.net>
Date: Thu, 11 Dec 2003 20:24:40 -0500
From: RunNHide <res0g1ta@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5.1) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 intio.o build errors
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [4.4.161.12] at Thu, 11 Dec 2003 19:24:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okay - I'm not a n00b but I'm no C programmer or driver developer, 
either - figured I'd post this - understand there's not a lot of this 
hardware out there so maybe this will be helpful:

  CC [M]  drivers/scsi/ini9100u.o
drivers/scsi/ini9100u.c:111:2: #error Please convert me to 
Documentation/DMA-mapping.txt
drivers/scsi/ini9100u.c:146: warning: initialization from incompatible 
pointer type
drivers/scsi/ini9100u.c:151: warning: initialization from incompatible 
pointer type
drivers/scsi/ini9100u.c:152: warning: initialization from incompatible 
pointer type
drivers/scsi/ini9100u.c: In function `i91uAppendSRBToQueue':
drivers/scsi/ini9100u.c:241: error: structure has no member named `next'
drivers/scsi/ini9100u.c:246: error: structure has no member named `next'
drivers/scsi/ini9100u.c: In function `i91uPopSRBFromQueue':
drivers/scsi/ini9100u.c:268: error: structure has no member named `next'
drivers/scsi/ini9100u.c:269: error: structure has no member named `next'
drivers/scsi/ini9100u.c: In function `i91uBuildSCB':
drivers/scsi/ini9100u.c:507: error: structure has no member named `address'
drivers/scsi/ini9100u.c:516: error: structure has no member named `address'
make[2]: *** [drivers/scsi/ini9100u.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

Thanks,
RunNHide


