Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbTCQQfA>; Mon, 17 Mar 2003 11:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbTCQQe7>; Mon, 17 Mar 2003 11:34:59 -0500
Received: from comtv.ru ([217.10.32.4]:5592 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261762AbTCQQe7>;
	Mon, 17 Mar 2003 11:34:59 -0500
X-Comment-To: William Lee Irwin III
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rik van Riel <riel@surriel.com>, Paul Albrecht <palbrecht@uswest.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
References: <002401c2eb78$cca714e0$d5bb0243@oemcomputer>
	<Pine.LNX.4.44.0303171001030.2571-100000@chimarrao.boston.redhat.com>
	<20030317151004.GR20188@holomorphy.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 17 Mar 2003 19:37:22 +0300
In-Reply-To: <20030317151004.GR20188@holomorphy.com>
Message-ID: <m3znnugda5.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> William Lee Irwin (WLI) writes:

 WLI> On Mon, Mar 17, 2003 at 10:02:21AM -0500, Rik van Riel wrote:
 >> The mmap() syscall only sets up the VMA info, it doesn't fill in
 >> the page tables. That only happens when the process page faults.
 >> Note that filling in a bunch of page table entries mapping already
 >> present pagecache pages at exec() time might be a good idea.  It's
 >> just that nobody has gotten around to that yet...

 WLI> SVR4 did and saw an improvement wrt. page fault rate, according
 WLI> to Vahalia.

 WLI> I'd like to see whether this is useful for Linux.

I tried this on dual P3 year and half ago and didn't see any improvement


