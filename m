Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314669AbSDTRf3>; Sat, 20 Apr 2002 13:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314674AbSDTRf2>; Sat, 20 Apr 2002 13:35:28 -0400
Received: from 24.159.204.122.roc.nc.chartermi.net ([24.159.204.122]:39440
	"EHLO tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S314669AbSDTRf2>; Sat, 20 Apr 2002 13:35:28 -0400
Date: Sat, 20 Apr 2002 12:33:46 -0500 (CDT)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: PDC20268 TX2 support?
In-Reply-To: <E16yqWt-0000QP-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204201226530.25636-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, Alan Cox wrote:
> > the 2.4.19 timeframe. I'm curious what level of support folks are
> > expecting? Just basic IDE, or support for the hardware raid features?
>
> What hardware raid features ?

The FastTraK 100 TX2 has hardware raid (stripe/mirror) support, they
have a binary only driver (scsi/ft.o) which presents this array as
a scsi device... this is the level of function I was hoping was being
integrated.

> AFAIK their only cards with hardware raid features are the supertrak 100 and
> SX6000.

The fasttrak also has hardware raid, while it works, it works realtively
well.

The current 2.4.18 code recognizes the card and provides vanilla IDE
access to the drives, unfortunately that isn't much use unless someone
wants to try and RE their block allocation on the disks... a decidedly
non-trivial endeavour I can assure you. ;(

-- 
Never make a technical decision based upon the politics of the situation.
Never make a political decision based upon technical issues.
The only place these realms meet is in the mind of the unenlightened.
			-- Geoffrey James, The Zen of Programming

