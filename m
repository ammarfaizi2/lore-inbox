Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbUCBSGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUCBSGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:06:30 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:35351 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261727AbUCBSG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:06:28 -0500
Date: Tue, 2 Mar 2004 19:07:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Dillow <dave@thedillows.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is the 2.6 dependency information complete? Doesn't look so...
Message-ID: <20040302180730.GD2135@mars.ravnborg.org>
Mail-Followup-To: Dave Dillow <dave@thedillows.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040229235150.GA6327@merlin.emma.line.org> <20040301060859.GA2129@mars.ravnborg.org> <1078163528.22900.17.camel@dillow.idleaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078163528.22900.17.camel@dillow.idleaire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 12:52:08PM -0500, Dave Dillow wrote:
> 
> Also, the changesets at bk://typhoon.bkbits.net/autoget-2.5 add
> functionality to kbuild to checkout needed files automatically, as the
> build progresses -- no more 'bk get' needed...
> 
> I haven't kept it up to date, but I doubt it'd need many changes to work
> with a recent kernel. It's currently BK/SCCS specific, but I do not
> think it would be hard to make it work with other version control
> systems, as long as make supports them.
> 
> Since you do so much in kbuild, I'd love some comments on it, if you
> have time.

I have pulled the tree, and the getfiles script and Makefile.repo is easy to spot.
Could you drop a mail with the rest of your changes as a regular patch?

I will then try to look through what you made - but my first impression is that this
is by far too much overhead just to replace an "bk -r co -Sq".

	Sam
