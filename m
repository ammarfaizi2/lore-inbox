Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRA0UAd>; Sat, 27 Jan 2001 15:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132311AbRA0UAP>; Sat, 27 Jan 2001 15:00:15 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:29701 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S131958AbRA0UAJ>; Sat, 27 Jan 2001 15:00:09 -0500
Date: Sat, 27 Jan 2001 20:58:51 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: Frank v Waveren <fvw@var.cx>, David Wagner <daw@cs.berkeley.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010127205851.B2501@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com> <14960.56461.296642.488513@pizda.ninka.net> <3A70DDC4.6D1DB1EC@transmeta.com> <3A713B3F.24AC9C35@idb.hist.no> <94tho8$627$1@abraham.cs.berkeley.edu> <20010127191809.A3727@var.cx> <20010127142032.E6821@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010127142032.E6821@xi.linuxpower.cx>; from greg@linuxpower.cx on Sat, Jan 27, 2001 at 02:20:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:
> > Why? Why not just zero them, and get both security and compatibility...
> 
> Eeek! NO!!!! NO NO NO NO NO NO NO!
> For ECN that would have worked, but that doesn't mean that something
> couldn't have been implimented there that wouldn't have worked that way..
> 
> I think that older Checkpoint firewalls (perhaps current?) zeroed out SACK
> on 'hide nat'ed connections. This causes unreasonable stalls for users on
> SACK enabled clients. Not cool.

If both SACK and SACK_PERMITTED were zeroed out, the clients would
negotiate non-SACK connections and everythings ok.  A performance
disadvantage relative to allowing SACK, but that's true of ECN as well.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
