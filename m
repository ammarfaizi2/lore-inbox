Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbULQXK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbULQXK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbULQXK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:10:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262224AbULQXKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:10:23 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20041217154018.C21393@almesberger.net> 
References: <20041217154018.C21393@almesberger.net>  <20041217153602.D31842@almesberger.net> 
To: Werner Almesberger <werner@almesberger.net>
Cc: linux-kernel@vger.kernel.org,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] prio_tree: move general code from mm/ to lib/ 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Fri, 17 Dec 2004 23:10:15 +0000
Message-ID: <3700.1103325015@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <werner@almesberger.net> wrote:

> 
> Note that this patch conflicts with a patch in 2.6.10-rc3-mm1
> (frv-better-mmap-support-in-uclinux.patch), which removes
> mm/prio_tree in systems without an MMU. Not making that other
> patch provide a dummy for prio_tree_init should resolve the
> conflict. (That's just from reading the patch - I haven't
> actually tried this.)

The prio_tree stuff can go back in for the nommu stuff. I've given Andrew a
patch to that effect (copied to LKML).

	Subject: [PATCH] Cross-reference nommu VMAs with mappings
	Date: 	Wed, 15 Dec 2004 15:55:35 +0000

David
