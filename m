Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUE0Vqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUE0Vqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUE0Vqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:46:48 -0400
Received: from thunk.org ([140.239.227.29]:52706 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261704AbUE0Vqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:46:45 -0400
Date: Thu, 27 May 2004 17:46:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040527214638.GA18349@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"La Monte H.P. Yarroll" <piggy@timesys.com>,
	Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <40B6591C.80901@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B6591C.80901@timesys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 05:09:48PM -0400, La Monte H.P. Yarroll wrote:
> >We are, with care.  It's in the changelogs.  Every single patch which I
> >didn't originate has a From: line at the start of the changelog.
> >
> For patches that I've been involved with, the changelog line almost always
> mentions one of the intermediate handlers, not the original author.  I 
> suspect that Larry is mostly right.

Up until recently we've had the person doing the BK commit, plus
person they received it from.  That's identical to the two-level chain
of custody which Larry was proposing as being "good enough" most of
the time.  But more recently, there have been changelog comments like
this:

ChangeSet@1.1743.1.52, 2004-05-25 08:43:49-07:00, akpm@osdl.org
  [PATCH] minor sched.c cleanup

  Signed-off-by: Christian Meder <chris@onestepahead.de>
  Signed-off-by: Ingo Molnar <mingo@elte.hu>

  The following obviously correct patch from Christian Meder simplifies the
  DELTA() define.

Which do show the original author.  

						- Ted
