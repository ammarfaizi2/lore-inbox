Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVDGGtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVDGGtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 02:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVDGGtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 02:49:09 -0400
Received: from ozlabs.org ([203.10.76.45]:20451 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261571AbVDGGtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 02:49:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16980.55403.190197.751840@cargo.ozlabs.ibm.com>
Date: Thu, 7 Apr 2005 16:51:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

> That "individual patches" is one of the keywords, btw. One thing that BK 
> has been extremely good at, and that a lot of people have come to like 
> even when they didn't use BK, is how we've been maintaining a much finer- 
> granularity view of changes. That isn't going to go away. 

Are you happy with processing patches + descriptions, one per mail?
Do you have it automated to the point where processing emailed patches
involves little more overhead than doing a bk pull?  If so, then your
mailbox (or patch queue) becomes a natural serialization point for the
changes, and the need for a tool that can handle a complex graph of
changes is much reduced.

> In fact, one impact BK ha shad is to very fundamentally make us (and me in
> particular) change how we do things.

>From my point of view, the benefits that flowed from your using BK
were:

* Visibility into what you had accepted and committed to your
  repository
* Lower latency of patches going into your repository
* Much reduced rate of patches being dropped

Those things are what have enabled us PPC developers to move away from
having our own trees (with all the synchronization problems that
entailed) and work directly with your tree.  I don't see that it is
the distinctive features of BK (such as the ability to do merges
between peer repositories) that are directly responsible for producing
those benefits, so I have hope that things can work just as well with
some other system.

Paul.
