Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVDBX6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVDBX6W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVDBX6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 18:58:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:24261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261388AbVDBX6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 18:58:08 -0500
Date: Sat, 2 Apr 2005 15:57:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: yum.rayan@gmail.com, rddunlap@osdl.org, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c - fix warning and reduce stack usage -
 reintroduction of mistakenly dropped patch
Message-Id: <20050402155741.7e467ce9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0504030139090.2525@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504030139090.2525@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> However, it seems you did *not* roll 
>  figure-out-who-is-inserting-bogus-modules-warning-fix.patch into 
>  figure-out-who-is-inserting-bogus-modules.patch but instead just dropped 
>  the patch.

I meant to drop it - it was just a debug thing, and we fixed the bug ages
ago and people kept on trying to fix the debug patch.

