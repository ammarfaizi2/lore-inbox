Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVDJWdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVDJWdh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDJWdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:33:37 -0400
Received: from kalmia.hozed.org ([209.234.73.41]:20642 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S261624AbVDJWdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:33:31 -0400
Date: Sun, 10 Apr 2005 17:33:30 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Daniel Phillips <phillips@istop.com>
Cc: Dmitry Yusupov <dima@neterion.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050410223330.GA26127@kalmia.hozed.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <200504071354.34581.phillips@istop.com> <1112897620.3893.62.camel@beastie> <200504071429.25073.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <200504071429.25073.phillips@istop.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 02:29:24PM -0400, Daniel Phillips wrote:
> On Thursday 07 April 2005 14:13, Dmitry Yusupov wrote:
> > On Thu, 2005-04-07 at 13:54 -0400, Daniel Phillips wrote:
> > > Three years ago, there was no fully working open source distributed scm
> > > code base to use as a starting point, so extending BK would have been the
> > > only easy alternative.  But since then the situation has changed.  There
> > > are now several working code bases to provide a good starting point:
> > > Monotone, Arch, SVK, Bazaar-ng and others.
> >
> > Right. For example, SVK is pretty mature project and very close to 1.0
> > release now. And it supports all kind of merges including Cherry-Picking
> > Mergeback:
> >
> > http://svk.elixus.org/?MergeFeatures
> 
> So for an interim way to get the patch flow back online, SVK is ready to try 
> _now_, and we only need a way to import the version graph?  (true/false)

Well, I followed some of the instructions to mirror the kernel tree on
svn.clkao.org/linux/cvs, and although it took around 12 hours to import
28232 versions, I seem to have a mirror of it on my own subversion
server now. I think the svn.clkao.org mirror was taken from bkcvs... the
last log message I see is "Rev 28232 - torvalds - 2005-04-04 09:08:33"

I have no idea what's missing. What is everyone's favorite web frontend
to subversion? I've got websvn (debian package) on there now, and it's a
bit sluggish, but it seems to work.

I hope to have time this week or next to actually make this machine
publicly accessible.
