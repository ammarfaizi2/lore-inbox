Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270180AbRHMNJq>; Mon, 13 Aug 2001 09:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270183AbRHMNJg>; Mon, 13 Aug 2001 09:09:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44036 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270180AbRHMNJ2>; Mon, 13 Aug 2001 09:09:28 -0400
Subject: Re: Are we going too fast?
To: pf-kernel@mirkwood.net (PinkFreud)
Date: Mon, 13 Aug 2001 14:11:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net> from "PinkFreud" at Aug 13, 2001 03:43:05 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WHVE-0007N6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> of them have suffered from one malady or another - from the dual PIII with
> the VIA chipset and Matrox G400 card, which locks up nicely when I switch

Welcome to wacky hardware. To get a G400 stable on x86 you need at least

XFree86 4.1 if you are running hardware 3D (and DRM 4.1)
2.4.8 or higher with the VIA fixes
Preferably a very recent BIOS update for the VIA box

Of those only the XFree hardware 3d stuff is software bug related.

> emergency sync) when attempting to use 'ls' on a mounted QNX filesystem
> (ls comes up fine, then system crashes - nothing sent to syslog, no errors
> on screen, nothing!) - and this latest is with 2.4.8!

The qnxfs code is experimental - so I can believe it might fail in 2.4. I'd
be very interested in info on that one.

> Should development continue on the latest and supposedly greatest
> drivers?  Or should the existing bugs be fixed first?  I've got at least
> three up there that need taking care of, and I'm sure others on this list
> have found more.  3 seperate crashes on 3 seperate installs on 3 seperate
> boxes - that's 100% failure rate.  If I get 100% failure on my installs,
> what are others seeing?

Near enough 0%. But then I try and avoid buying broken chipsets.

> I like Linux.  I'd like to stick with it.  But if it's going to
> continually crash, I'm going to jump ship - and I'll start recommending to

If you want maximum stability you want to be running 2.2 or even 2.0. Newer
less tested code is always less table. 2.4 wont be as stable as 2.2 for a
year yet.

Alan
