Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVGGKnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVGGKnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVGGKlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:41:47 -0400
Received: from gold.veritas.com ([143.127.12.110]:76 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261289AbVGGKlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:41:36 -0400
Date: Thu, 7 Jul 2005 11:42:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: P@draigBrady.com, linux-kernel@vger.kernel.org
Subject: Re: How do you accurately determine a process' RAM usage?
In-Reply-To: <20050707014005.338ea657.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507071129360.18479@goblin.wat.veritas.com>
References: <42CC2923.2030709@draigBrady.com> <20050706181623.3729d208.akpm@osdl.org>
 <42CCE737.70802@draigBrady.com> <20050707014005.338ea657.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Jul 2005 10:41:31.0985 (UTC) FILETIME=[70648C10:01C582E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Andrew Morton wrote:
> P@draigBrady.com wrote:
> 
> > Looks like it's been stable for 4 months?
> 
> yup, although I don't think it's been used much.

Just a sidenote to say I should be sending you an update to it
(the /proc/$pid/smaps code) in the next couple of days, but merely
cosmetic ("map" -> "vma", cond_resched_lock, p?d_addr_next ptwalking).

I'm still pretty sceptical about it, but it's probably a useful
framework for people to hack on, to report whatever kind of page
numbers they're interested in for this or that investigation.

Hugh
