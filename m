Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUA1Awi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265687AbUA1Awg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:52:36 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:26887 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265678AbUA1Awf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:52:35 -0500
Date: Wed, 28 Jan 2004 00:52:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: thockin@sun.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: NGROUPS 2.6.2rc2
Message-ID: <20040128005233.A22886@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, thockin@sun.com, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <20040127225311.GA9155@sun.com> <20040127164615.38fd992e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040127164615.38fd992e.akpm@osdl.org>; from akpm@osdl.org on Tue, Jan 27, 2004 at 04:46:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 04:46:15PM -0800, Andrew Morton wrote:
> rant.  We have soooo many syscalls declared in .c files.  We had a bug due
> to this a while back.  Problem is, we have no anointed header in which to
> place them.  include/linux/syscalls.h would suit.  And unistd.h for
> arch-specific syscalls.  But that's not appropriate to this patch.

I did that in the linux-abi patch for 2.4 and even submitted it a few
times before 2.5 forked, but Linus didn't seem to like it.

