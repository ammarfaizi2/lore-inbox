Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265257AbUD3U3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbUD3U3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUD3U3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:29:43 -0400
Received: from thunk.org ([140.239.227.29]:27101 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265257AbUD3U3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:29:38 -0400
Date: Fri, 30 Apr 2004 16:29:15 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christof <mail@pop2wap.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: some ext2-understanding problems (page cache etc.)
Message-ID: <20040430202915.GB23131@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christof <mail@pop2wap.net>, linux-kernel@vger.kernel.org
References: <4091AA0F.8050700@pop2wap.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4091AA0F.8050700@pop2wap.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 03:21:19AM +0200, Christof wrote:
> Hello,
> 
> I'm not a kernel guru, but my task is to extract some ext2-code from the 
> kernel into user space for a scientific project/experiment. I've 
> "ported" a lot of code by now but now I am stuck.
> I wanted to bypass the page cache and disk buffer and have all writes 
> and reads directly in memory. I don't want to get into details, but 
> imagine I have an image of an ext2-filesystem in memory and want to 
> access it in user space but with the same interface as it would be in 
> the kernel.

You're probably better off using the the libext2fs library that is
part of e2fsprogs, since it is already userspace code.  

						- Ted
