Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTEJUtW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTEJUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:49:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:18694 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264499AbTEJUtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:49:21 -0400
Date: Sat, 10 May 2003 23:01:39 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: akpm@digeo.com
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [USB] [PATCH] Crud-- (was: Re: [ATM] [UPDATE] unbalanced usw)
Message-ID: <20030510230139.B17835@electric-eye.fr.zoreil.com>
References: <20030510062015.A21408@infradead.org> <200305101352.h4ADqoGi014392@locutus.cmf.nrl.navy.mil> <20030510161219.GB5580@kroah.com> <20030510213906.A17835@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030510213906.A17835@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, May 10, 2003 at 09:39:06PM +0200
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> :
[...]
> diff -puN drivers/usb/class/usb-midi.c~codingstyle-patrol-usb drivers/usb/class/usb-midi.c
> --- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/usb/class/usb-midi.c~codingstyle-patrol-usb	Sat May 10 20:34:14 2003
> +++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/usb/class/usb-midi.c	Sat May 10 21:29:42 2003
> @@ -1355,8 +1355,10 @@ static struct usb_midi_device *parse_des
>  		next = p2 + p2[0];
>  		length -= p2[0];
>  
> -		if (p2[0] < 2 ) break;
> -		if (p2[1] != USB_DT_CS_INTERFACE) break;
> +		if (p2[0] < 2 )
> +			break;
> +		if (p2[1] != USB_DT_CS_INTERFACE)r
                                                !!!
> +			break;

... and the winner of the "Bozo of the week award" is Francois Romieu
for his new concept of compilation checking without .config update.

I'll send a link for an update once it at least compiles.

--
Ueimor
