Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268233AbTALESz>; Sat, 11 Jan 2003 23:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268234AbTALESz>; Sat, 11 Jan 2003 23:18:55 -0500
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:46752 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S268233AbTALESy>; Sat, 11 Jan 2003 23:18:54 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
References: <Pine.LNX.4.44.0301111953060.1401-100000@home.transmeta.com>
From: Derek Atkins <warlord@MIT.EDU>
Date: 11 Jan 2003 23:27:40 -0500
In-Reply-To: <Pine.LNX.4.44.0301111953060.1401-100000@home.transmeta.com>
Message-ID: <sjmlm1r2ds3.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Oh, well. Can you verify whether this fixes it for you? And thanks for 
> hunting down the exact changeset.

Thanks.  This patch does indeed fix it for me.  And you're welcome --
I learned a lot about bitkeeper in the process of tracking this down.
FTR, BK *DID* make it a lot easier to visualize the graph so I could
walk backwards and track it down.

> Btw, what version of "init" are you running? It would be interesting to 
> see what it actually does, and obviously none of the machines I have 
> around have that init.. 

Red Hat's SysVinit-2.84-2.

> 		Linus

-derek
-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
