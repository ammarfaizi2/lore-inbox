Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbSKUX3Z>; Thu, 21 Nov 2002 18:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267168AbSKUX3Z>; Thu, 21 Nov 2002 18:29:25 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:14819 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S267159AbSKUX3R>;
	Thu, 21 Nov 2002 18:29:17 -0500
Subject: Re: Unsupported AGP-bridge on VIA VT8633
From: Stian Jordet <liste@jordet.nu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021121231432.GA28783@suse.de>
References: <1037916067.813.7.camel@chevrolet.hybel>
	 <20021121221134.GA25741@suse.de>
	 <1037917231.3ddd5c2f5d98a@webmail.jordet.nu>
	 <20021121224035.GA28094@suse.de> <1037919383.856.3.camel@chevrolet.hybel>
	 <20021121231432.GA28783@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1037921829.1318.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 22 Nov 2002 00:37:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 2002-11-22 kl. 00:14 skrev Dave Jones:
> On Thu, Nov 21, 2002 at 11:56:23PM +0100, Stian Jordet wrote:
>  > >  > I'll do that now. But why do I have to use agp_try_unsupported=1?
>  > > Because if it works, we can then add it to the ID table.
>  > It works, i think. I get this message when I load it:
>  > Linux agpgart interface v0.99 (c) Jeff Hartmann
>  > agpgart: Maximum main memory to use for agp memory: 439M
>  > agpgart: Trying generic Via routines for device id: 3091
>  > agpgart: AGP aperture is 64M @ 0xf8000000
> 
> And it survives a 3d app / testgart run ?

Yes, it does. I have a Radeon 9700 Pro, and I have been running XFree86
cvs to get 2d support. This has worked perfect for me. But yesterday ATI
launched their binary drivers, and I wanted to give them a try. Then I
had to get agp working. And after I got your mail, I thought everything
was going just fine. Everything loaded fine, but the computer locked up
everytime something 3d appeared. At this time I wasn't sure what I
should blame. The driver, og the agpgart. So I found my old Radeon
All-in-Wonder, with good DRI-support, and now it works perfect :)

So to make a long story short (too late), the agpgart seems to work
perfect, altough my Radeon 9700 Pro didn't.

>  > Thank you very much. I'm very sorry if this was a lame question.
> 
> No problem. I'll add this ID to the pending patch I have
> for Linus to add various other GARTs.

Great! Thank you :)

Regards,
Stian Jordet

(Off to play more tuxracer before I switch cards again)

