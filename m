Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTEGNyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbTEGNyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:54:19 -0400
Received: from imap.gmx.net ([213.165.65.60]:54731 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263199AbTEGNyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:54:18 -0400
Message-ID: <3EB911C3.902@gmx.net>
Date: Wed, 07 May 2003 16:01:39 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <200305071518.25595.arnd@arndb.de>
In-Reply-To: <200305071518.25595.arnd@arndb.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Wednesday 07 May 2003 14:41, Pavel Machek wrote:
> 
> Ok. I now noticed there are some more problems that I did not see
> at first:
> 
> 
>>--- linux.clean/drivers/block/Makefile	2003-05-05 15:49:42.000000000 -0700
>>+++ linux/drivers/block/Makefile	2003-05-06 13:53:24.000000000 -0700
>>@@ -25,7 +25,7 @@
>> obj-$(CONFIG_BLK_DEV_PS2)	+= ps2esdi.o
>> obj-$(CONFIG_BLK_DEV_XD)	+= xd.o
>> obj-$(CONFIG_BLK_CPQ_DA)	+= cpqarray.o
>>-obj-$(CONFIG_BLK_CPQ_CISS_DA)  += cciss.o
>>+obj-$(CONFIG_BLK_CPQ_CISS_DA)	+= cciss.o
>> obj-$(CONFIG_BLK_DEV_DAC960)	+= DAC960.o
> 
> 
> huh?

Tab vs. spaces


Carl-Daniel

