Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266201AbUHVFhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbUHVFhG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUHVFhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:37:06 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:17876 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266201AbUHVFhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:37:02 -0400
Date: Sun, 22 Aug 2004 01:41:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org, kaos@sgi.com
Subject: Re: [PATCH][1/4] Completely out of line spinlocks / i386
In-Reply-To: <20040821113556.368c7be5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0408220138540.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408211320520.27390@montezuma.fsmlabs.com>
 <20040821113556.368c7be5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
> >
> > the focus of this patch is for reduced kernel image size
>
> By how much does it reduce kernel image size?

Something like;

  text    data     bss     dec     hex filename
5527214  873510  321872 6722596  669424 vmlinux-before
5480308  867964  321872 6670144  65c740 vmlinux-after
