Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVCAV5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVCAV5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCAV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:57:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:16352 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262090AbVCAV44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:56:56 -0500
Date: Tue, 1 Mar 2005 13:58:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1
Message-Id: <20050301135852.6f0b3bee.akpm@osdl.org>
In-Reply-To: <20050301201631.GF4845@stusta.de>
References: <20050301012741.1d791cd2.akpm@osdl.org>
	<20050301201631.GF4845@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Tue, Mar 01, 2005 at 01:27:41AM -0800, Andrew Morton wrote:
> >...
> > All 728 patches:
> >...
> > reiser4-rcu-barrier.patch
> >   reiser4: add rcu_barrier() synchronization point
> 
> Considering the patent situation at least in the USA, the 
> EXPORT_SYMBOL(rcu_barrier) has to become an EXPORT_SYMBOL_GPL.

I'll make that change.

> > reiser4-export-inode_lock.patch
> >   reiser4: export inode_lock to modules
> >...
> 
> __iget seems to be no longer used by reiser4.
> This part of the patch can therefore be dropped.

And that one.
