Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268509AbTBWQPA>; Sun, 23 Feb 2003 11:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268510AbTBWQPA>; Sun, 23 Feb 2003 11:15:00 -0500
Received: from [212.156.4.132] ([212.156.4.132]:51967 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S268509AbTBWQO7>;
	Sun, 23 Feb 2003 11:14:59 -0500
Date: Sun, 23 Feb 2003 18:25:04 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oom killer and its superior braindamage in 2.4
Message-ID: <20030223162504.GA3137@ttnet.net.tr>
Mail-Followup-To: David Mansfield <lkml@dm.cobite.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302231058070.23778-100000@admin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302231058070.23778-100000@admin>
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This exact thing happened to me as well, on a 2.4.20-pre that hasn't been 
> upgraded to 2.4.20 yet.  The thing that concerns me most is:
> 
> Why won't the system kill the process it claims to be killing?
> 
> If, in Marc's case, the system wants to kill PID 2657, a lowly sleeping 
> apache process, why can't it?  This is a bug for sure.
> 
> For me, there was some python process chosen as the one for killing and it 
> repeated the 'Out of Memory: Killed process xxxxx (python)' for hours 
> while making no progress.  The machine was still routing packets but I 
> couldn't log in.  Sys-rq was disabled, so I was forced to use the big red 
> button.
> 
> Rik, any ideas?

But, did you follow that thread? Rik van Riel, already suggested a solution for
the problem.

http://marc.theaimsgroup.com/?l=linux-kernel&m=104594301523518&w=2








