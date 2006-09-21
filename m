Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWIUWlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWIUWlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWIUWlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:41:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44464 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932085AbWIUWlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:41:04 -0400
Date: Thu, 21 Sep 2006 18:40:51 -0400
From: Dave Jones <davej@redhat.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Sean <seanlkml@sympatico.ca>, Dax Kelson <dax@gurulabs.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20060921224051.GS26683@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Lang <dlang@digitalinsight.com>, Sean <seanlkml@sympatico.ca>,
	Dax Kelson <dax@gurulabs.com>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <BAYC1-PASMTP025A72C81CFE009C3BB5A5AE200@CEZ.ICE> <20060921175717.272c58ee.seanlkml@sympatico.ca> <Pine.LNX.4.63.0609211455570.17238@qynat.qvtvafvgr.pbz> <20060921222443.GO26683@redhat.com> <Pine.LNX.4.63.0609211514470.17238@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609211514470.17238@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 03:16:57PM -0700, David Lang wrote:
 > On Thu, 21 Sep 2006, Dave Jones wrote:
 > 
 > > On Thu, Sep 21, 2006 at 03:00:48PM -0700, David Lang wrote:
 > >
 > > > for the tarball users they would have to grab
 > > > multiple patches to get from the last thing that they have to whatever is
 > > > current.
 > >
 > > ketchup solves that problem. One command brings any tree up to current.
 > 
 > so are you saying that ketchup should be used for _all_ access to the vanilla 
 > tree that isn't done via git?
 > if not then tarballs still have a place.

I think you have a misunderstanding over what ketchup is/does.
It cannot usurp tarballs by its very nature. It retrieves tarballs (if necessary)
and whatever patches are necessary to get to the tree you want.
http://www.selenic.com/ketchup/
 
 > and how does ketchup deal with patched trees to start with?

By unpatching if necessary.

 > > > also people could be behind a firewall that prevents git from working properly,
 > > > for them tarballs and patches are the right way of doing things.
 > >
 > > If they can't git through a firewall, they won't be able to wget a tarball through
 > > it either.
 > 
 > to work properly git should talk it's own protocol, http/ftp can be allowed (and 
 > authenticated) through firewalls that don't allow the git protocol.

'properly' is the wrong word here. optimally, yes, but the firewall argument
alone isn't sufficient to claim git can't be used to clone a tree.
A tree cloned over http: vs one over git: has exactly the same information in
it. All the history, all the changes. Everything.

	Dave
