Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRKMMVt>; Tue, 13 Nov 2001 07:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276057AbRKMMVj>; Tue, 13 Nov 2001 07:21:39 -0500
Received: from m216-mp1-cvx2a.lee.ntl.com ([62.252.240.216]:38273 "EHLO
	box.penguin.power") by vger.kernel.org with ESMTP
	id <S273269AbRKMMVY>; Tue, 13 Nov 2001 07:21:24 -0500
Date: Tue, 13 Nov 2001 12:20:33 +0000
From: Gavin Baker <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Cc: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS630 and 5591/5592 AGP
Message-ID: <20011113122033.A9379@box.penguin.power>
In-Reply-To: <5.1.0.14.0.20011112101656.00a20630@mail.amc.localnet> <20011111185930.A2700@box.penguin.power> <5.1.0.14.0.20011112101656.00a20630@mail.amc.localnet> <20011112163604.A5384@box.penguin.power> <5.1.0.14.0.20011113105444.009f3ec0@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <5.1.0.14.0.20011113105444.009f3ec0@mail.amc.localnet>; from sgy@amc.com.au on Tue, Nov 13, 2001 at 11:15:11AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 11:15:11AM +1100, Stuart Young wrote:

> At 04:36 PM 12/11/01 +0000, Gavin Baker wrote:
> >Im currently using vesa for X, I would like to get some kind of 
> >acceleration to play DVD's etc. I've tried the sis_drv in X 4.1 with the 
> >lavalamp style effect i mentioned, the sis driver in X3.x gets the screen 
> >offset totally wrong, ie the center of the screen is on the far right of 
> >the physical screen, but this is a problem i can direct to the X lists.
> 
> You'll find a post from me there back in October, and a patch to X (and a 
> binary module) linked to. The files are still there, and contains details 
> on how to try the work-around.

Im using your patched sis_drv.o for X now. The performance increase is
noticable, but the Xv display still can't keep up with any highbandwidth video
(even 352x288 mpeg), so my dream of DVD playback is still far off but a lot
closer. ;)

> >Im sure other laptops with different badges on them will have the same
> >internals.
> 
> Gotta love reference designs.

Sure, when they are well supported reference designs :)

> >Everything else (except the software modem, which i have no use for)
> >worked straight out of the tin with RedHat 7.2's vanilla kernel. Im
> >current using Alans 2.4.13-ac8:
> 
> The sisfb driver changes appeared in 2.4.13-ac4, so I'd guess they'd be in 
> 2.4.13-ac8. Unfortunately (afaik) Alan hasn't gotten much in the way of 
> e-mail response from SiS on his questions. The driver made an appearance 
> early in the 2.4 series, and was 'reverted' back to the old one as SiS 
> didn't respond to questions about the code, which afaik seemed "inconsistent".

The SiS Framebuffer has the problem thats been mentioned where it
does'nt talk to the CRT/LCD controller correctly. It displays to the 
CRT _almost_ perfectly, but sends garbage to the LCD, i guess its the same 
for you. 

I will never understand the logic behind a company _not_ helping produce
drivers for their hardware under our favourite OS. The only reason i can
even think of is if their hardware needs huge ugly hacks that binary
drivers hide.
 
> Can you e-mail me (may as well be off-list) the dump of 'lspci -bv' please? 

done.

Cheers, Gavin Baker
