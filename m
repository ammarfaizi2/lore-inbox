Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIDs5>; Mon, 8 Jan 2001 22:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAIDsr>; Mon, 8 Jan 2001 22:48:47 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:60054 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S129383AbRAIDsj>; Mon, 8 Jan 2001 22:48:39 -0500
Date: Tue, 9 Jan 2001 04:48:34 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
Message-ID: <20010109044834.I4991@khan.acc.umu.se>
In-Reply-To: <3A5A4958.CE11C79B@goingware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A5A4958.CE11C79B@goingware.com>; from crawford@goingware.com on Mon, Jan 08, 2001 at 11:12:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 11:12:24PM +0000, Michael D. Crawford wrote:

[snipped a lot of sane opinions]
> While Be, Inc.'s implementation is closed-source, the design of the
> BFS (_not_ "befs" as it is sometimes called) is explained in Practical
> File System Design with the Be File System by Dominic Giampolo, ISBN
> 1-55860-497-9.  Dominic has since left Be and I understand works at
> Google now.

The reason why BFS is often referred to as BeFS, is that there is a
another file-system, far older than Be's filesystem AFAIK, called BFS;
the SCO Unixware Boot File System, which is already supported in the
Linux-kernel. Hence the misnomer BeFS. I think we should keep it that
way to avoid confusion... After all, BeFS does indicate pretty well what
file-system we mean, and other alternatives, such as be_bfs, or renaming
SCO BFS to sco_bfs or similar feels awkward.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
