Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVDHXi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVDHXi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVDHXi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:38:28 -0400
Received: from smtp.istop.com ([66.11.167.126]:47272 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261197AbVDHXiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:38:25 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Kernel SCM saga..
Date: Fri, 8 Apr 2005 19:38:30 -0400
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random>
In-Reply-To: <20050408083839.GC3957@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504081938.31118.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 April 2005 04:38, Andrea Arcangeli wrote:
> On Thu, Apr 07, 2005 at 11:41:29PM -0700, Linus Torvalds wrote:
> The huge number of changesets is the crucial point, there are good
> distributed SCM already but they are apparently not efficient enough at
> handling 60k changesets.
>
> We'd need a regenerated coherent copy of BKCVS to pipe into those SCM to
> evaluate how well they scale.
>
> OTOH if your git project already allows storing the data in there,
> that looks nice ;).

Hi Andrea,

For the immediate future, all we need is something than can _losslessly_ 
capture the new metadata that's being generated.  That buys time to bring one 
of the promising open source candidates up to full speed.

By the way, which one are you working on? :-)

Regards,

Daniel
