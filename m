Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVHIUwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVHIUwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVHIUwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:52:20 -0400
Received: from smtp.istop.com ([66.11.167.126]:12178 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S964957AbVHIUwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:52:19 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Wed, 10 Aug 2005 06:52:38 +1000
User-Agent: KMail/1.7.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <42F57FCA.9040805@yahoo.com.au> <200508100514.13672.phillips@arcor.de> <Pine.LNX.4.61.0508092112050.16395@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508092112050.16395@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508100652.39241.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 August 2005 06:17, Hugh Dickins wrote:
> There might be a case for packaging repeated arguments into structures
> (though several of these levels are inlined anyway), but that's some
> other exercise entirely, shouldn't get in the way of removing Reserved.

Agreed, an entirely separate question that I'd like to return to in time.  The 
existing herd of page table walkers is unnecessarily repetitious.

Regards,

Daniel
