Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285548AbRL2VD7>; Sat, 29 Dec 2001 16:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285517AbRL2VDq>; Sat, 29 Dec 2001 16:03:46 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:32615 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285568AbRL2VDf>; Sat, 29 Dec 2001 16:03:35 -0500
Date: Sat, 29 Dec 2001 16:03:34 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229160334.A9919@redhat.com>
In-Reply-To: <20011229190600.2556C36DE6@hog.ctrl-c.liu.se> <Pine.LNX.4.43.0112291313160.18183-100000@waste.org> <20011229113749.D19306@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011229113749.D19306@work.bitmover.com>; from lm@bitmover.com on Sat, Dec 29, 2001 at 11:37:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 11:37:49AM -0800, Larry McVoy wrote:
> If you have N people trying to patch the same file, you'll require N
> releases and some poor shlep is going to have to resubmit their patch
> N-1 times before it gets in.

Wrong.  Most patches are independant, and even touch different functions.  
Things like "add member foo of type baz to struct z" are independant 
changes even if they conflict when patching.

> Anyway, I'm interested to see if there are screams of "all I ever do is
> merge and I hate it" or "merging?  what's that?".

How about "I'm sick of resending this one line bugfix to maintainer of 
$foo who keeps dropping it"?  That's the problem that patchbot is meant 
to solve, not the merging problem.  If the people responsible for applying 
patches were perfect, we wouldn't need it.

		-ben
