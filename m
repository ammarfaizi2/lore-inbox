Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUFVAfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUFVAfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 20:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266535AbUFVAfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 20:35:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:3220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266534AbUFVAfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 20:35:38 -0400
Date: Mon, 21 Jun 2004 17:38:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joshua Kwan <jkwan@rackable.com>
Cc: linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: Re: What happened to linux/802_11.h?
Message-Id: <20040621173827.0403618b.akpm@osdl.org>
In-Reply-To: <pan.2004.06.21.22.25.18.591967@triplehelix.org>
References: <pan.2004.06.21.22.25.18.591967@triplehelix.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan <jkwan@rackable.com> wrote:
>
> Hello,
> 
> linus.patch from -mm1:
> # BitKeeper/deleted/.del-802_11.h~9b6bd4cff8af7a90
> #   2004/06/18 09:47:58-07:00 torvalds@ppc970.osdl.org +0 -0
> #   Delete: include/linux/802_11.h
> 
> Why was this file removed?

Nothing in the kernel is using it.

> The IPW2100 driver
> (http://ipw2100.sourceforge.net) uses its definitions and now won't build
> against -bk or -mm kernel source.

Jean, should we restore 802_11.h, or is there some alternative file which
that driver should be using?

