Return-Path: <linux-kernel-owner+w=401wt.eu-S1751296AbXANOgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbXANOgP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 09:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXANOgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 09:36:15 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:42881 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751296AbXANOgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 09:36:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=CT3+YWW6DMY3O+tjn8nm6+kR/vDxDGicITdBj7w+S3jtQXCy3YGOLYC1D1AQVxO75R+jj4GVlsvPrQsZ+2L//MPzo151qrzJ3RHy/2JFAAwRnFY62E8RL0XCj5nPP9AYHfE25AY5ahkDEqV1WW2KIlagHEwmKDx/7OpvGTmaZxc=  ;
X-YMail-OSG: 3GVQzPgVM1l3MjTVFIP61fN0hAjIlp2XNmrWMLjx7RnN96T_pqzCz462ZifT4l82T2CVOy1nOTDriUPmB2.AO_lIapNnLr5TT_W0R1HkNXtXSBiR5Ey_hxxpdh777P2kAmXXVGk35lPprw--
From: David Brownell <david-b@pacbell.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.20-rc4-mm1: different values for OHCI_QUIRK_ZFMICRO
Date: Sun, 14 Jan 2007 06:36:10 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Tony Olech <tony.olech@elandigitalsystems.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070114091016.GS7469@stusta.de>
In-Reply-To: <20070114091016.GS7469@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701140636.11657.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 January 2007 1:10 am, Adrian Bunk wrote:
> <--  snip  -->

Waiting for Tony to submit bugfixes to his driver...


> ...
>   CC      drivers/usb/misc/ftdi-elan.o
> /home/bunk/linux/kernel-2.6/linux-2.6.20-rc4-mm1/drivers/usb/misc/ftdi-elan.c:2307:1: warning: "OHCI_QUIRK_ZFMICRO" redefined
> In file included from /home/bunk/linux/kernel-2.6/linux-2.6.20-rc4-mm1/drivers/usb/misc/ftdi-elan.c:76:
> /home/bunk/linux/kernel-2.6/linux-2.6.20-rc4-mm1/drivers/usb/misc/../host/ohci.h:399:1: warning: this is the location of the previous definition
> ...
> $ grep -r ^#define * | grep OHCI_QUIRK_ZFMICRO  
> drivers/usb/host/ohci.h:#define OHCI_QUIRK_ZFMICRO      0x20                   /* Compaq ZFMicro chipset*/
> drivers/usb/host/u132-hcd.c:#define OHCI_QUIRK_ZFMICRO 0x10
> drivers/usb/misc/ftdi-elan.c:#define OHCI_QUIRK_ZFMICRO 0x10
> $ 
> 
> <--  snip  -->
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
