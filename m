Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265036AbUFANiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbUFANiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUFANiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:38:19 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:31688 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265036AbUFANiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:38:12 -0400
Date: Tue, 1 Jun 2004 15:37:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040601133753.GC14572@wohnheim.fh-wedel.de>
References: <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040601055616.GD15492@wohnheim.fh-wedel.de> <20040601060205.GE15492@wohnheim.fh-wedel.de> <20040601122013.GA10233@elf.ucw.cz> <20040601132712.GB14572@wohnheim.fh-wedel.de> <20040601133228.GB5926@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040601133228.GB5926@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 June 2004 15:32:29 +0200, Pavel Machek wrote:
> > 
> > I'm open for suggestions. ;)
> 
> /*! Recursion-count: 2 Whatever-else: 5 */

What I need is:
1. Recursion count
2. All functions involved in the recursion in the correct order (a
   calls b calls c calls d calls a, something like that).

How do you pass 2?

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c
