Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbUKVOky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbUKVOky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUKVOi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:38:58 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:61133 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261279AbUKVO1a (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:27:30 -0500
Date: Mon, 22 Nov 2004 14:27:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Nikita Danilov <nikita@clusterfs.com>
cc: Andrew Morton <akpm@osdl.org>, <Linux-Kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH]: 2/4 mm/swap.c cleanup
In-Reply-To: <16801.6313.996546.52706@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0411221419100.2867-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Nikita Danilov wrote:
> Andrew Morton writes:
>  > 
>  > Sorry, this looks more like a dirtyup to me ;)
> 
> Don't tell me you are not great fan on comma operator abuse. :)
> 
> Anyway, idea is that by hiding complexity it loop macro, we get rid of a
> maze of pvec-loops in swap.c all alike.
> 
> Attached is next, more typeful variant. Compilebootentested.

You're scaring me, Nikita.  Those loops in mm/swap.c are easy to follow,
whyever do you want to obfuscate them with your own macro maze?

Ingenious for_each macros make sense where it's an idiom which is going
to be useful to many across the tree; but these are just a few instances
in a single source file.

Please find a better outlet for your talents!

Hugh

