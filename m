Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268625AbTCCWAH>; Mon, 3 Mar 2003 17:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268626AbTCCWAH>; Mon, 3 Mar 2003 17:00:07 -0500
Received: from pirx.hexapodia.org ([208.42.114.113]:37800 "HELO
	pirx.hexapodia.org") by vger.kernel.org with SMTP
	id <S268625AbTCCWAG>; Mon, 3 Mar 2003 17:00:06 -0500
Date: Mon, 3 Mar 2003 16:10:33 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
Message-ID: <20030303161033.A7473@hexapodia.org>
References: <20030220062323.GX351@lug-owl.de> <Pine.LNX.3.96.1030220060638.14551A-101000@gatekeeper.tmr.com> <20030220113624.GP351@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030220113624.GP351@lug-owl.de>; from jbglaw@lug-owl.de on Thu, Feb 20, 2003 at 12:36:24PM +0100
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 12:36:24PM +0100, Jan-Benedict Glaw wrote:
> This reminds me that I wanted to have a look at an additional feature -
> building the kernel _not_ within its source tree. So I wouldn't need to
> place 10 copies of the kernel onto disk / into memory...
> 
> Haven't I seen patches flyin' around? Anyone?

You can save your buffercache memory by doing a
"cp -al linux-2.5.61 linux-2.5.61-buildfoo", for each value of buildfoo,
and do your builds in a cloned tree.  Hard links save the day!

-andy
