Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932758AbWAKFb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbWAKFb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWAKFb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:31:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932758AbWAKFbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:31:25 -0500
Date: Tue, 10 Jan 2006 21:30:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: reuben-lkml@reub.net, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-Id: <20060110213056.58f5e806.akpm@osdl.org>
In-Reply-To: <20060110213001.265a6153.akpm@osdl.org>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43BFD8C1.9030404@reub.net>
	<20060107133103.530eb889.akpm@osdl.org>
	<43C38932.7070302@reub.net>
	<20060110104759.GA30546@elte.hu>
	<43C3A85A.7000003@reub.net>
	<20060110044240.3d3aa456.akpm@osdl.org>
	<20060110131618.GA27123@elte.hu>
	<17348.34472.105452.831193@cse.unsw.edu.au>
	<43C4947C.1040703@reub.net>
	<20060110213001.265a6153.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >
> > I'm tempted to see if I can narrow it down to a specific -gitX release, maybe 
> >  that would narrow it down to say, 200 or so patches ;-)
> 
> If -mm2 plus -mm2's linus.patch does not fail then
> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt will
> find the dud patch.

Actually 2.6.15-mm1 would be a better one to do the bisection on: it has
all the md- patches separated out.
