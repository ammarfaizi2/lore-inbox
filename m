Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752001AbWCBQLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbWCBQLo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWCBQLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:11:44 -0500
Received: from twin.jikos.cz ([213.151.79.26]:60588 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1752001AbWCBQLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:11:43 -0500
Date: Thu, 2 Mar 2006 17:11:32 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Chris Wright <chrisw@sous-sol.org>
cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Hauke Laging <mailinglisten@hauke-laging.de>,
       linux-kernel@vger.kernel.org
Subject: Re: VFS: Dynamic umask for the access rights of linked objects
In-Reply-To: <20060301075915.GD27645@sorel.sous-sol.org>
Message-ID: <Pine.LNX.4.58.0603021707400.12446@twin.jikos.cz>
References: <200603010328.42008.mailinglisten@hauke-laging.de>
 <44050AB7.7020202@vilain.net> <200603010454.15223.mailinglisten@hauke-laging.de>
 <08AB14CC-2BB2-4923-BFDB-B1360B5EF405@mac.com> <20060301075915.GD27645@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Chris Wright wrote:

> Solar Designer's Openwall Linux patch contains code for these types of
> restrictions (at least since 2.2 if not earlier).  Idea was stolen and
> made into an LSM smth like 4 or 5 years ago.  Neither of these have made
> it upstream.  Attempts have also been made to codify such restrictions
> in SELinux policy.  Polyinstantiation and per-process namespaces can be
> done effectively with code that's now in mainline, and can mitigate much
> of this risk.

Just to make the discussion complete, I point out to the paper about a 
thing called RaceGuard, presented at USENIX some time ago - 
http://www.usenix.org/events/sec01/full_papers/cowanbeattie/cowanbeattie.pdf

-- 
JiKos.
