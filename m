Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVDUNdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVDUNdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVDUNdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:33:44 -0400
Received: from hermes.domdv.de ([193.102.202.1]:37892 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261349AbVDUNdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:33:42 -0400
Message-ID: <4267ABB6.2080208@domdv.de>
Date: Thu, 21 Apr 2005 15:33:42 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile error on x86_64:

  CC [M]  drivers/usb/image/microtek.o
drivers/usb/image/microtek.c: In function `mts_scsi_abort':
drivers/usb/image/microtek.c:338: error: `FAILURE' undeclared (first use
in this function)
drivers/usb/image/microtek.c:338: error: (Each undeclared identifier is
reported only once
drivers/usb/image/microtek.c:338: error: for each function it appears in.)
make[3]: *** [drivers/usb/image/microtek.o] Error 1
make[2]: *** [drivers/usb/image] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
