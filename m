Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTLJRvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTLJRvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:51:50 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:39571 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263809AbTLJRvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:51:44 -0500
Date: Wed, 10 Dec 2003 18:49:23 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hua Zhong <hzhong@cisco.com>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210174923.GA27073@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <00af01c3bf41$2db12770$d43147ab@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 December 2003 09:15:15 -0800, Hua Zhong wrote:
> 
> Many userspace programs fall into this category too. For example they
> depend on /proc to be there. They probably only work with a certain
> version of the kernel because the next version changed some format in
> /proc.
> 
> Is /proc a stable API/ABI? Yes? No?

Have you ever played roleplaying games?  Almost every rule system has
gray areas that could be exploited by the player.  But if you really
try to do it, the game master will simply notice that - as unlikely as
it sounds - a meteor just landed on your head and you are dead.

Try to use /proc/kcore to load kernel modules through a gray area and
the game master (aka judge) will notice.  Use it to check the kernel
version and noone cares.  So common sense applies again, no matter how
tricky your questions are.

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
