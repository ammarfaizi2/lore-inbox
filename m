Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTHVF75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 01:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbTHVF74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 01:59:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:24768 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262951AbTHVF74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 01:59:56 -0400
Date: Thu, 21 Aug 2003 22:59:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm3 - cp -a kills machine
In-Reply-To: <20030822015658.GD3958@waste.org>
Message-ID: <Pine.LNX.4.44.0308212259000.3258-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Aug 2003, Matt Mackall wrote:
> > No console message either. Repeated after taking out local APIC
> > support, same thing.
> 
> Similar repeatable problems with periodic fsck on ext3 root. Appears
> not to be ext3 or loop, perhaps something IDE-related in Linus' bk
> tree added between mm2 and mm3.

The more you can track this down, the easier it will be for us. Willing to 
triangulate a bit? For example, just start testing the suspicious parts of 
the patch?

		Linus

