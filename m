Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLPLji>; Sat, 16 Dec 2000 06:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131676AbQLPLj3>; Sat, 16 Dec 2000 06:39:29 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:38046 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S129340AbQLPLjM>; Sat, 16 Dec 2000 06:39:12 -0500
Date: Sat, 16 Dec 2000 12:08:42 +0100
From: David Weinehall <tao@acc.umu.se>
To: Lee Leahu <lee@ricis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: VFS: LRU block list corrupted
Message-ID: <20001216120842.A1851@khan.acc.umu.se>
In-Reply-To: <5.0.0.25.2.20001215205029.00a8a688@mail.ricis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <5.0.0.25.2.20001215205029.00a8a688@mail.ricis.com>; from lee@ricis.com on Fri, Dec 15, 2000 at 09:04:31PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 09:04:31PM -0600, Lee Leahu wrote:
> Hello all,
> 
> One of my linux servers crash with a 'kernal panic: VFS: LRU block list 
> corrupted' message on my screen.
> I reboot with a boot disk - it was find, then rebooted of the hard drive 
> and it was fine.  The systems is runing fine
> now, but i thought maybe someone on this list could explain to me what 
> exactly happend there.

Uhm. First of all, you really need to supply information on what
kernel-version this is. Any hardware information is useful too. And
the oops seem to come from klogd, right? klogd has a horrific tendency
of destroying all information in the oops, thus it's recommended to
call klogd with the '-x' argument to tell it not to decode oops:es.

Then, when you get an oops, run it through ksymoops.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
