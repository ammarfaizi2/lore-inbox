Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTBUH2q>; Fri, 21 Feb 2003 02:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTBUH2p>; Fri, 21 Feb 2003 02:28:45 -0500
Received: from waste.org ([209.173.204.2]:43209 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267219AbTBUH2p>;
	Fri, 21 Feb 2003 02:28:45 -0500
Date: Fri, 21 Feb 2003 01:38:38 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
Message-ID: <20030221073838.GI28107@waste.org>
References: <Pine.LNX.4.44.0302201810160.32017-100000@localhost.localdomain> <Pine.LNX.4.44.0302200920550.2493-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302200920550.2493-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 09:22:42AM -0800, Linus Torvalds wrote:
> 
> On Thu, 20 Feb 2003, Ingo Molnar wrote:
> > 
> > Al says that this cannot be done sanely, and is fraught with security
> > problems. I'd vote for it if it were possible. Al?
> 
> I seriously doubt it. It's all exactly the same as the _current_ 
> /proc/<pid> stuff, it just shows up in a different place.

Well perhaps that was just Al's way of saying the current stuff is
broken too. I think we could get into trouble reparenting or exec'ing
really quickly though.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
