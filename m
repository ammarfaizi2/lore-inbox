Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSKUWsx>; Thu, 21 Nov 2002 17:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKUWsx>; Thu, 21 Nov 2002 17:48:53 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:5603 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S265177AbSKUWsb>;
	Thu, 21 Nov 2002 17:48:31 -0500
Subject: Re: Unsupported AGP-bridge on VIA VT8633
From: Stian Jordet <liste@jordet.nu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021121224035.GA28094@suse.de>
References: <1037916067.813.7.camel@chevrolet.hybel>
	 <20021121221134.GA25741@suse.de>
	 <1037917231.3ddd5c2f5d98a@webmail.jordet.nu>
	 <20021121224035.GA28094@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1037919383.856.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 21 Nov 2002 23:56:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2002-11-21 kl. 23:40 skrev Dave Jones:
> On Thu, Nov 21, 2002 at 11:20:31PM +0100, Stian Jordet wrote:
> 
>  > You were not really clear here. I tried it as a boot-time argument, because I
>  > have agp-support compiled in. But I guess I could and should try it as a module.
> 
> Yup. Then do a `modprobe agpgart agp_try_unsupported=1'
> 
>  > I'll do that now. But why do I have to use agp_try_unsupported=1?
> 
> Because if it works, we can then add it to the ID table.

It works, i think. I get this message when I load it:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Trying generic Via routines for device id: 3091
agpgart: AGP aperture is 64M @ 0xf8000000

Thank you very much. I'm very sorry if this was a lame question.

Thanks.

Regards,
Stian Jordet

