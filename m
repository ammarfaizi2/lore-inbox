Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266868AbUAXG0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 01:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266875AbUAXG0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 01:26:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:38610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266868AbUAXG0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 01:26:19 -0500
Date: Fri, 23 Jan 2004 22:26:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Sid Boyce <sboyce@blueyonder.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2 kernel oops
In-Reply-To: <20040123211242.4dc0c770.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401232225520.10144@home.osdl.org>
References: <4011AB0B.4030906@blueyonder.co.uk> <20040123211242.4dc0c770.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jan 2004, Andrew Morton wrote:
>
> Sid Boyce <sboyce@blueyonder.co.uk> wrote:
> >
> > I get this on bootup, Athlon XP2200+
> > =====================================
> > Linux version 2.6.2-rc1-mm2 (root@barrabas) (gcc version 3.3.1 (SuSE 
> > ...
> > EIP is at test_wp_bit+0x36/0x90
> 
> oh crap, why does this thing keep breaking?  Please send your .config over,
> thanks.

Problems with the exception table sorting?

Does plain 2.6.2-rc1 work?

		Linus
