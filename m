Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269976AbRHJTWb>; Fri, 10 Aug 2001 15:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269985AbRHJTWV>; Fri, 10 Aug 2001 15:22:21 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:65284 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269976AbRHJTWI>; Fri, 10 Aug 2001 15:22:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Writes to mounted devices containing file-systems.
Date: 10 Aug 2001 12:21:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9l1c86$2jv$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> In this company, they hired a "CIO" who thinks that no computers
> should have any local storage or boot capability. They must all
> boot from some secure (M$) file-server. They will not be allowed
> to have local disks and, horrors -- of course no floppy drives or
> CD-ROMS.
> 

This is actually a lot easier to do in Linux (using PXELINUX and
NFSroot) -- M$ thinks of this as a threat to their licensing
(fleecing) model.

Seriously, you should use this as an inroad -- central control setups
is something Unix absolutely excels at, and Windows does hideously
poorly.

> He doesn't care that we are in the business of making software-driven
> machines so we require access to the guts of computers and their
> operating systems.

Test machines obviously can't be done this way, but they shouldn't
contain important data.  (And don't expect great performance, either,
although with modern file servers and networks it can be better than
you'd think.)

> The next one will be:
> 
> 	"Linux is insecure..."

Consider SirCam and Code Red an "education campaign" for the
clueless.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
