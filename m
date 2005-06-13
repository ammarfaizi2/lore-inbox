Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVFMTub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVFMTub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVFMTub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:50:31 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:60074 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S261246AbVFMTtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:49:05 -0400
Date: Mon, 13 Jun 2005 21:48:54 +0200 (CEST)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub4.ifh.de
To: randy_dunlap <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH -mm] dvb: dibusb needs license
In-Reply-To: <20050613122751.4e7820b4.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0506132147030.22217@pub4.ifh.de>
References: <20050613122751.4e7820b4.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Jun 2005, randy_dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> Module needs a license to prevent kernel tainting.
>
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>
> diffstat:=
> drivers/media/dvb/dvb-usb/dibusb-common.c |    2 +-
> drivers/media/dvb/dvb-usb/dvb-usb.h       |    1 +
> 2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff -Naurp ./drivers/media/dvb/dvb-usb/dibusb-common.c~taint_dvb ./drivers/media/dvb/dvb-usb/dibusb-common.c
> --- ./drivers/media/dvb/dvb-usb/dibusb-common.c~taint_dvb	2005-06-10 18:42:28.000000000 -0700
> +++ ./drivers/media/dvb/dvb-usb/dibusb-common.c	2005-06-13 11:07:17.000000000 -0700
> @@ -13,6 +13,7 @@
> static int debug;
> module_param(debug, int, 0644);
> MODULE_PARM_DESC(debug, "set debugging level (1=info (|-able))." DVB_USB_DEBUG_STATUS);
> +MODULE_LICENSE("GPL");
>
> #define deb_info(args...) dprintk(debug,0x01,args)

Thanks for pointing that out. Committed to linux-dvb CVS for being in 
sync.

regards,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
