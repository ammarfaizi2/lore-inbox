Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTIJREG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbTIJREG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:04:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38558
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265291AbTIJREC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:04:02 -0400
Date: Wed, 10 Sep 2003 19:05:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910170534.GM21086@dualathlon.random>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030910165944.GL21086@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910165944.GL21086@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 06:59:44PM +0200, Andrea Arcangeli wrote:
> About the implementation - the locking looks very wrong: you miss the
> page_table_lock in all the pte walking, you take a totally worthless
> lock_kernel() all over the place for no good reason, and the

sorry for the self followup, but I just read another message where you
mention 2.2, if that was for 2.2 the locking was the ok.

all other problems remains though.

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
