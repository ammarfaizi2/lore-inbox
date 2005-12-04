Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVLDIpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVLDIpX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 03:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVLDIpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 03:45:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9131 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751331AbVLDIpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 03:45:22 -0500
Date: Sun, 4 Dec 2005 00:44:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, Simon.Derr@bull.net
Subject: Re: How do I remove a patch buried in your *-mm series?
Message-Id: <20051204004437.327c9a8c.akpm@osdl.org>
In-Reply-To: <20051204003134.7c899d0f.pj@sgi.com>
References: <20051203234900.fcaa6caf.pj@sgi.com>
	<20051204001525.2889f924.akpm@osdl.org>
	<20051204003134.7c899d0f.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> So ... not E ;).  What's your preference now?

http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 is a patch against
-rc4 containing everything in -mm up to and including 

...
radix-tree-code-consolidation
radix_tree-early-termination-of-tag-clearing
radix-tree-reduce-tree-height-upon-partial-truncation
slob-introduce-mm-utilc-for-shared-functions
slob-introduce-the-slob-allocator
slob-introduce-the-slob-allocator-fixes
cpuset-better-bitmap-remap-defaults
cpuset-mempolicy-one-more-nodemask-conversion
cpuset-memory-pressure-meter
cpuset-memory-pressure-meter-gcc-295-fix
cpuset-document-additional-features

So a patch against that will be ideal.

(It's very easy for me to create such a rollup - one has but to ask...)
