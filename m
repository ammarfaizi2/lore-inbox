Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbVH3BDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVH3BDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 21:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVH3BDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 21:03:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751435AbVH3BDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 21:03:22 -0400
Date: Mon, 29 Aug 2005 18:03:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ray Fucillo <fucillo@intersystems.com>, Hugh Dickins <hugh@veritas.com>,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <4313A85E.4000502@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0508291802220.3243@g5.osdl.org>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com>
 <Pine.LNX.4.63.0508261910080.8057@cuia.boston.redhat.com>
 <Pine.LNX.4.58.0508261621410.3317@g5.osdl.org> <43108136.1000102@yahoo.com.au>
 <Pine.LNX.4.61.0508280500450.3323@goblin.wat.veritas.com> <43115E67.1050305@yahoo.com.au>
 <43139B62.7010502@intersystems.com> <4313A85E.4000502@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Aug 2005, Nick Piggin wrote:
> 
> Andrew, did you pick up the patch or should I resend to someone?

I picked it up. If it causes performance regressions, we can fix them, and
if it causes other problems then that will be interesting in itself.

		Linus
