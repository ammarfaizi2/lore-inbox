Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUDQPkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 11:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263982AbUDQPkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 11:40:16 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:37892 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263735AbUDQPkM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 11:40:12 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: Error compiling kernel 2.6.4 with dpt_i2o driver
Date: Sat, 17 Apr 2004 17:36:58 +0200
User-Agent: KMail/1.6.1
Cc: =?iso-8859-15?q?V=E1g=E1si_L=E1szl=F3?= <l.vagasi@mai-cee.com>,
       Mark Salyzyn <Mark_Salyzyn@adaptec.com>
References: <40814CEA.7040706@mai-cee.com>
In-Reply-To: <40814CEA.7040706@mai-cee.com>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404171736.58126@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 April 2004 17:27, Vágási László wrote:

Hi Vágási,

> My company is running a Degian GNU Linux on a dual Intel PII 933MHz
> system with 1 GB RAM.
> Currently it is running kernel 2.4.22 which supports our Adaptec 2100S
> raid controller using the dpt_i2o driver.
>
> We decided to change to kernel 2.6.x (I have tried 2.6.0, 2.6.1, 2.6.4)
> but it fails to compile.
> Here are some lines from the output:
> drivers/scsi/dpt_i2o.c:32:2 #error Please convert me to
> Documentation/DMA-mapping.txt
> drivers/scsi/dpt_i2o.c: In function 'adpt_install_hba':
> drivers/scsi/dpt_i2o.c:997: warning: passing arg 2 of 'request_irq' from
> incompatible pointer type
> drivers/scsi/dpt_i2o.c: I function 'adpt_scsi_to_i25':
> drivers/scsi/dpt_i2o.c:2118: structure has no member named 'address'
> drivers/scsi/dpt_i2o.c: At top level:
> drivers/scsi/dpt_i2o.c:165: warning: 'dptids' defined but not used

http://www.kernel.org/pub/linux/kernel/people/mcp/2.6-WOLK/linux-2.6.4-wolk2.0-broken-out/2203_adaptec_dpt_i2o.patch

Mark: Is there a newer one which applies to 2.6.5/2.6.6-rc1||-bk*?

ciao, Marc
