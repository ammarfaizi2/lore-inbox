Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUGAU1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUGAU1v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGAU1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:27:51 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:10658 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S266254AbUGAU1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:27:50 -0400
Date: Thu, 1 Jul 2004 13:27:44 -0700
Message-Id: <200407012027.i61KRiFd021854@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andrea Arcangeli <andrea@suse.de>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: Linus Torvalds's message of  Thursday, 1 July 2004 08:49:10 -0700 <Pine.LNX.4.58.0407010843450.11212@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It even gets the pid of the child in the siginfo 
> structure if it really wants to see that..

Unless there were two deaths quickly before it got scheduled to run its
signal handler.  Then it only finds out one of the relevant PIDs.


Thanks,
Roland
