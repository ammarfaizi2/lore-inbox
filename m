Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbUEWRzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUEWRzg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUEWRzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:55:36 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:20492 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S263219AbUEWRze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:55:34 -0400
Subject: Re: [RFD] Explicitly documenting patch submission
From: Joe Perches <joe@perches.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085334933.8494.1448.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 23 May 2004 10:55:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-22 at 23:46, Linus Torvalds wrote:
> So what I'm suggesting is that we start "signing off" on patches, to show 
> the path it has come through, and to document that chain of trust.  It 
> also allows middle parties to edit the patch without somehow "losing" 
> their names - quite often the patch that reaches the final kernel is not 
> exactly the same as the original one, as it has gone through a few layers 
> of people.

I suggest that the current BK PULL methods be indirected.

Instead of "signed-off-by", how about an explicit email to the
author(s) and a pre-commit email list with required ACK(s) prior
to commit?  Email acks are perhaps a better chain of trust than
a signature line.

Use of BK has lost some of the "many-eyeballs" positives of the past.
Today's BkCommits-Head list only allows an after-the-fact review.
Frequently, the patch author and sometimes the maintainer are the
only parties to the change.  A pre-commit list could allow comments by
interested parties on patches that today are under reviewed.


