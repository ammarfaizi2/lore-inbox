Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbRERSXv>; Fri, 18 May 2001 14:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbRERSXl>; Fri, 18 May 2001 14:23:41 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:13512 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S261426AbRERSXg>; Fri, 18 May 2001 14:23:36 -0400
Date: Fri, 18 May 2001 13:23:35 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <OF61000B59.7C828594-ON84256A4E.004122CC@urscorp.com>
Message-ID: <Pine.LNX.4.33.0105181321040.15850-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2001 mike_phillips@urscorp.com wrote:
> > The same situation appears when using bonding.o. For several years,
> > Don Becker's (and derived) network drivers support changing MAC address
> > when the interface is down. So Al's /dev/eth/<n>/MAC has different
> values
> > depending on whether bonding is active or not. Should /dev/eth/<n>/MAC
> > always have the original value (to be able to uniquely identify this
> card)
> > or the in-use value (used by ARP, I believe) ? Or maybe have a
> > /dev/eth/<n>/MAC_in_use ?
>
> Token ring has the same problem as well, most token ring adapters support
> setting a LAA.

Ethernet cards have both a fixed "hardware" address and the mutable
"physical" address.  How about TR?  And how many cards give you no access
to the hardware address?

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

