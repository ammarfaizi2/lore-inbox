Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSJFODW>; Sun, 6 Oct 2002 10:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbSJFODW>; Sun, 6 Oct 2002 10:03:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36103 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261615AbSJFODV>; Sun, 6 Oct 2002 10:03:21 -0400
Date: Sun, 6 Oct 2002 15:08:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>, Ulrich Drepper <drepper@redhat.com>,
       bcollins@debian.org, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BK MetaData License Problem?
Message-ID: <20021006150854.C31147@flint.arm.linux.org.uk>
References: <20021006144821.B31147@flint.arm.linux.org.uk> <Pine.LNX.4.44.0210061601040.7386-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210061601040.7386-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Oct 06, 2002 at 04:10:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 04:10:46PM +0200, Ingo Molnar wrote:
> it *is* a BK problem caused by BK becase now this whole can of worms got
> silently exported to the kernel tree, and while BM itself is safe via its
> license, the kernel tree 'as a whole' is exposed.

Actually, the more I think about it, the more you are correct.

The way BK openlogging works, it exports personal information out of the
EU.  This is explicitly prohibited under EU law, unless the owner of that
personal information has explicitly granted that it may be used in that
manner.

Therefore, I'd stronlg advise people in the EU not to use BK's BK_USER/
BK_HOST feature when importing patches.

The following question remains though: peoples names are "personal
information."  Personal information falls under the UK data protection
act, which is one implementation of the EU law.  This means that unless
Alan has an explicit agreement with every person who has sent him a patch,
he has no right to publish the list of names in his change log, especially
when that information travels leaves the EU.

This is certainly an interesting problem.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

