Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261538AbTCOUSf>; Sat, 15 Mar 2003 15:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbTCOUSe>; Sat, 15 Mar 2003 15:18:34 -0500
Received: from [195.39.17.254] ([195.39.17.254]:13060 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261538AbTCOURl>;
	Sat, 15 Mar 2003 15:17:41 -0500
Date: Sun, 16 Mar 2003 14:45:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org,
       ockman@penguincomputing.com, dev@work.bitmover.com
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030316134558.GH8057@zaurus.ucw.cz>
References: <20030312034330.GA9324@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312034330.GA9324@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> (actually Wayne Scott) did was to write a graph traversal alg which
> finds the longest path through the revision history which includes
> all tags.  For the 2.5 tree, that is currently 8298 distinct points.
> Each of those points has been captured in CVS as a commit.  If we did

As far as I can see, linux-2.5 repository has over 17000 ChangeSets,
that means half the granularity. Would it be possible to use cvs branches
to capture tree structure and have special form of commit comment
"this is merge of changeset 1.2.3.4"?
That way BK->CVS conversion could
preserve all the data...
				Pavel 
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

