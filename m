Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbRGXODy>; Tue, 24 Jul 2001 10:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbRGXODo>; Tue, 24 Jul 2001 10:03:44 -0400
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:8944 "HELO
	duron.intern.kubla.de") by vger.kernel.org with SMTP
	id <S267540AbRGXODc>; Tue, 24 Jul 2001 10:03:32 -0400
Date: Tue, 24 Jul 2001 16:03:26 +0200
From: Dominik Kubla <kubla@sciobyte.de>
To: Michael Poole <poole@troilus.org>
Cc: Paul Jakma <paul@clubi.ie>, linux-kernel@vger.kernel.org
Subject: Re: Arp problem
Message-ID: <20010724160326.G31198@intern.kubla.de>
In-Reply-To: <Pine.LNX.4.33.0107240208460.10839-100000@fogarty.jakma.org> <20010724140916.F31198@intern.kubla.de> <87k80y8qsz.fsf@cj46222-a.reston1.va.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k80y8qsz.fsf@cj46222-a.reston1.va.home.com>
User-Agent: Mutt/1.3.18i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 08:17:16AM -0400, Michael Poole wrote:
> 
> This may be a stupid question, but does
>   cat 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
> help the problem any (for the proper value of "eth0")?  A college
> roommate of mine once had the same problem, and clearing
> send_redirects for the interface fixed it for him.
> 
> -- Michael Poole

It may be a work-around, but it does not solve the problem.
There are legitimate uses of redirects and simply disabling them
might cause different problems.  The correct solution is to have
the kernel treat aliased interfaces the same as interfaces on
different networking cards.

Dominik
-- 
ScioByte GmbH, Zum Schiersteiner Grund 2, 55127 Mainz (Germany)
Phone: +49 6131 550 117  Fax: +49 6131 610 99 16

GnuPG: 717F16BB / A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
