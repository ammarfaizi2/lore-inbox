Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUE1PVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUE1PVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUE1PVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:21:40 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:18405 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263338AbUE1PVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:21:37 -0400
Date: Fri, 28 May 2004 16:19:19 +0100
From: Dave Jones <davej@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Larry McVoy <lm@work.bitmover.com>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040528151919.GC11265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Larry McVoy <lm@work.bitmover.com>,
	"La Monte H.P. Yarroll" <piggy@timesys.com>,
	Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <40B6591C.80901@timesys.com> <20040527214638.GA18349@thunk.org> <20040528132436.GA11497@work.bitmover.com> <20040528150740.GF18449@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528150740.GF18449@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 11:07:40AM -0400, Theodore Ts'o wrote:
 > On Fri, May 28, 2004 at 06:24:36AM -0700, Larry McVoy wrote:
 > > Not in any useful way.  If I go look at the file history, which is what
 > > I'm going to do when tracking down a bug, all I see on the files included
 > > in this changeset is akpm@osdl.org.
 > > 
 > > That means any annotated listing (BK or CVS blame) shows the wrong author.
 > 
 > One of the ways that I often use for tracking down potential fixes is
 > to simply do "bk changes > /tmp/foo" and then use emacs's incremental
 > search to look for interesting potential changes.  (I know, you're
 > probably throwing up all over your keyboard just about now.  :-)
 > 
 > One "interesting" thing I've wished for is to be able to do "bk
 > revtool drivers/net/wireless/airo.c", and then when I put my mouse
 > over a particular line number, have it display in a little popup box 
 > the changelog description of whatever line my mouse happened to 
 > be over.

bk revtool $filename
ctrl-c in the gui that pops up
click line that looks interesting - jumps to the cset with
commit comments.

That what you meant ?

		Dave

