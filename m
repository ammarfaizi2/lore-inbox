Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265907AbUGHIMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUGHIMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 04:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUGHIMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 04:12:40 -0400
Received: from av7-2-sn4.m-sp.skanova.net ([81.228.10.109]:12497 "EHLO
	av7-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S265907AbUGHIMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 04:12:39 -0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Jul 2004 10:12:35 +0200
In-Reply-To: <40ECADF8.7010207@yahoo.com.au>
Message-ID: <m2fz82hq8c.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> Peter Osterlund wrote:
> > I created a test program that allocates a 300MB buffer and writes to
> > all bytes sequentially. On my computer, which has 256MB RAM and 512MB
> > swap, the program gets OOM killed after dirtying about 140-180MB, and
> > the kernel reports:
> >
> 
> Someone hand me a paper bag... Peter, can you give this patch a try?

Doesn't help. My test program still fails in the same way.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
