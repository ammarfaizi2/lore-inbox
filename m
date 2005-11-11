Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVKKANb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVKKANb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVKKANb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:13:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932139AbVKKANa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:13:30 -0500
Date: Thu, 10 Nov 2005 16:12:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pmarques@grupopie.com, jgarzik@pobox.com, axboe@suse.de, neilb@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: userspace block driver?
Message-Id: <20051110161259.1189a040.akpm@osdl.org>
In-Reply-To: <E1EZqZK-0001RV-00@dorka.pomaz.szeredi.hu>
References: <4371A4ED.9020800@pobox.com>
	<17265.42782.188870.907784@cse.unsw.edu.au>
	<4371A944.6070302@pobox.com>
	<20051109075455.GN3699@suse.de>
	<4371ACE6.7010503@pobox.com>
	<4371EEBA.2080706@grupopie.com>
	<E1EZpTU-0001KK-00@dorka.pomaz.szeredi.hu>
	<E1EZqZK-0001RV-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> N.B. though FUSE itself is free of deadlocks, as soon as you put
> something on top of it which has asyncronous page writeback it will
> not be safe anymore.

Why?   What goes wrong?
