Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbULZLgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbULZLgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 06:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbULZLgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 06:36:24 -0500
Received: from mail.linicks.net ([217.204.244.146]:1540 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261636AbULZLgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 06:36:20 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 typo in include/linux/netfilter.h
Date: Sun, 26 Dec 2004 11:36:18 +0000
User-Agent: KMail/1.7.2
References: <200412260917.38717.nick@linicks.net> <200412261059.57661.nick@linicks.net> <20041226132047.6ac71b4f@hotline4.alkar.net>
In-Reply-To: <20041226132047.6ac71b4f@hotline4.alkar.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412261136.18751.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 11:20, Roman Ivanchukov wrote:

Strange - really strange.  I was specific on that line as that is what GCC 
told me error was - and it was here.

> I've just downloaded linux-2.6.10.tar.bz2 from kernel.org and there is no
> such error in netfilter.h:
>
> /* Call setsockopt() */
> int nf_setsockopt(struct sock *sk, int pf, int optval, char __user *opt,
>                   int len);

I just DL'ed the tar.gz - that is OK.

The image build I done (using oldconfig) booted, but wouldn't mount disks, and 
a few other errors (like looking for modules - I don't build with modules).

What on earth could cause that then?  Corrupt download?  I would have thought 
nigh on impossible to get one or two errors like that if so?

Nick 
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
