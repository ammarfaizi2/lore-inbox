Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbULTRAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbULTRAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbULTRAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:00:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38101 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261571AbULTRAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:00:44 -0500
Date: Mon, 20 Dec 2004 09:00:32 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out CPU clock additions to posix-timers
In-Reply-To: <200412200347.iBK3lg3X007599@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0412200857480.6297@schroedinger.engr.sgi.com>
References: <200412200347.iBK3lg3X007599@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2004, Roland McGrath wrote:

> Since Andrew is taking the conservative line, I think it's more prudent to
> omit the whole thing from 2.6.10 rather than have a tentative definition of
> what those two clock IDs mean that changes later.

The conservative line is to keep a consistent definition of the interface
following posix as closely as possible. The definition of the 4 clockids
CLOCK_*_CPUTIME_ID, CLOCK_REALTIME and CLOCK_MONOTONIC should stay
constant and be implemented in a consistent way by the kernel. That is
the case now and should not be changed by any future patches.


