Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbTAKF3r>; Sat, 11 Jan 2003 00:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbTAKF3r>; Sat, 11 Jan 2003 00:29:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62983 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267081AbTAKF3q>; Sat, 11 Jan 2003 00:29:46 -0500
Date: Fri, 10 Jan 2003 21:33:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Derek Atkins <warlord@MIT.EDU>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
In-Reply-To: <sjmwulc46ml.fsf@kikki.mit.edu>
Message-ID: <Pine.LNX.4.44.0301102132570.9532-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jan 2003, Derek Atkins wrote:
>
> Ok, I'll work on tracking down the exact patches where the changeovers
> from 1->2 and 2->3 occur.  It's going to take me some time to
> continually back out patches and rebuild, but I'll work on it.
> Hopefully it will only take a couple days.
> 
> Any hints on ways to "move forward" as opposed to just moving
> backwards would be useful too.

None really good - just keep a (local) full tree around, and when you want 
to move forward you do a "bk pull" from that tree (or clone a whole new 
base tree to work with).

		Linus

