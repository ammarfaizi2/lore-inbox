Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268292AbUGXFVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268292AbUGXFVC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUGXFVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:21:02 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:2491 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268292AbUGXFVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:21:01 -0400
Date: Fri, 23 Jul 2004 22:21:00 -0700
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel@vger.kernel.org
Subject: Re: clearing filesystem cache for I/O benchmarks
Message-ID: <20040724052059.GB30718@taniwha.stupidest.org>
References: <87vfgeuyf5.fsf@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vfgeuyf5.fsf@osu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 06:54:54PM -0400, Benjamin Rutt wrote:

> How can I purge all of the kernel's filesystem caches, so I can
> trust that my I/O (read) requests I'm trying to benchmark bypass the
> kernel filesystem cache?

does "ioctl(fd, BLKFLSBUF,0)" suffice?


   --cw
