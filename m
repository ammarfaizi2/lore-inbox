Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263906AbTCXJm0>; Mon, 24 Mar 2003 04:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264019AbTCXJm0>; Mon, 24 Mar 2003 04:42:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30222 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263906AbTCXJmZ>;
	Mon, 24 Mar 2003 04:42:25 -0500
Date: Mon, 24 Mar 2003 01:53:08 -0800
From: Greg KH <greg@kroah.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB compile error with latest 2.5-bk
Message-ID: <20030324095308.GB5934@kroah.com>
References: <1048462471.1739.1.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048462471.1739.1.camel@tiger>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 06:34:31PM -0500, Louis Garcia wrote:
> I'm running RH phoebe beta
> 
>  gcc -Wp,-MD,drivers/usb/core/.hcd.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=pentium4
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> -iwithprefix include -DMODULE   -DKBUILD_BASENAME=hcd
> -DKBUILD_MODNAME=usbcore -c -o drivers/usb/core/.tmp_hcd.o
> drivers/usb/core/hcd.c
> drivers/usb/core/hcd.c:124: parse error before '>>' token
> drivers/usb/core/hcd.c:124: initializer element is not constant
> drivers/usb/core/hcd.c:124: (near initialization for
> `usb2_rh_dev_descriptor[12]')

I don't see this error with a older compiler.  I suggest filing a bug
with Red Hat's bugzilla.

thanks,

greg k-h
