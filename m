Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUCLDU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 22:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUCLDU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 22:20:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261931AbUCLDU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 22:20:26 -0500
Date: Thu, 11 Mar 2004 22:20:12 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.44.0403112315220.2671-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403112219580.21139-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Hugh Dickins wrote:

> Okay, Rik, the two extremes belong to you: one anon memory
> object in total (above), and one per page (your original rmap);
> whereas Andrea is betting on one per vma, and I go for one per mm.
> Each way has its merits, I'm sure - and you've placed two bets!

I suspect yours is the best mix.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

