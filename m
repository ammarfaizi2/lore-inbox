Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUFWSog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUFWSog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266604AbUFWSog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:44:36 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:5552 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S266603AbUFWSof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:44:35 -0400
To: David Ashley <dash@xdr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cached memory never gets released
References: <200406231835.i5NIZTSJ019899@xdr.com>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 23 Jun 2004 14:44:23 -0400
In-Reply-To: <200406231835.i5NIZTSJ019899@xdr.com> (David Ashley's message
 of "Wed, 23 Jun 2004 11:35:29 -0700")
Message-ID: <874qp2dshk.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ashley <dash@xdr.com> writes:

> There is some new information that might be useful. The cache memory
> lower limit seems to be going up by 1 or 2 megabytes whenever the kernel
> kills the XFree86 process:
> Jun 23 11:20:16 __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> Jun 23 11:20:16 VM: killing process XFree86
>
> Could it be when the kernel kills a process for trying to use up too much
> memory, the pages used by the process get left in some locked state so can
> never be reused?
>
> This is the sort of behaviour we're seeing, it is very reproduceable.
>
>
> Note this is kernel 2.4.23.

Have you tried a kernel that's less than 8 months old?  2.4.26 is current.

-Doug
