Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRC0EUY>; Mon, 26 Mar 2001 23:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRC0EUP>; Mon, 26 Mar 2001 23:20:15 -0500
Received: from ns0.petreley.net ([64.170.109.178]:3975 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S130487AbRC0EUF>;
	Mon, 26 Mar 2001 23:20:05 -0500
Date: Mon, 26 Mar 2001 20:19:23 -0800
From: Nicholas Petreley <nicholas@petreley.com>
To: linux-kernel@vger.kernel.org
Cc: Andre Hedrick <andre@linux-ide.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VIA686b chipset and dma_intr errors, and 3c905B errors
Message-ID: <20010326201923.C609@petreley.com>
In-Reply-To: <Pine.LNX.4.10.10103161041040.14210-100000@master.linux-ide.org> <3AB93A75.D18A78EE@student.luth.se> <20010326142858.A664@petreley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010326142858.A664@petreley.com>; from nicholas@petreley.com on Mon, Mar 26, 2001 at 02:28:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update: 

Thanks to some advice and help from Mark Hahn, I downloaded
the DFT utility from IBM that checks and fixes their
drives.  A low-level format fixed the problems (the utility
calls it "erase disk".  That seems odd to me, since I
thought that IDE drives automatically took care of bad
blocks, but apparently this needed the low-level format. 
I'll keep an eye on that drive, though...

As for the 3C905B, I've already replaced it with an
eepro100, but as Mark suggested in an email, I will turn
off the "optimal" performance setting in the BIOS and see
if that gets rid of all the bizarre behavior.  Apparently
that's not a kernel problem but a bios problem.  

-Nick

-- 
**********************************************************
Nicholas Petreley   Caldera Systems - LinuxWorld/InfoWorld
nicholas@petreley.com - http://www.petreley.com - Eph 6:12
**********************************************************
.
