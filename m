Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUFRU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUFRU5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUFRUxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:53:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:27833 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262101AbUFRUtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:49:02 -0400
Date: Fri, 18 Jun 2004 13:51:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: axboe@suse.de, dev@opensound.com, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-Id: <20040618135136.45581da7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0406181037180.8065-100000@chimarrao.boston.redhat.com>
References: <20040618082708.GD12881@suse.de>
	<Pine.LNX.4.44.0406181037180.8065-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> Maintaining a patch for one version of the distribution, in
> order to get a feature to customers sooner, is perfectly
> doable and may make economic sense.
> 
> Maintaining an out-of-tree patch forever because you didn't
> get around to merging it into the upstream kernel doesn't.

Problem is, what happens if vendor X ships a feature and that feature is
deemed unacceptable for the kernel.org kernel?

There are examples of this and as I've earlier indicated, I'd be OK with
merging some fairly stinky things after 2.7 forks off, as a service to the
major kernel.org customers and as a general lets-keep-things-in-sync
exercise.

But we then need to do it all again in 2.8.x.  It's hard to see how to fix
this apart from either merging everything into the main tree or dropping
things from vendor trees.  Or waiting for someone to come up with an
acceptable form of whatever it is the patch does.
