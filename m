Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTDNSWu (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbTDNSPP (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:15:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23054 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263645AbTDNSGy (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:06:54 -0400
Date: Mon, 14 Apr 2003 11:18:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Andries.Brouwer@cwi.nl, <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <Pine.LNX.4.44.0304142000460.12110-100000@serv>
Message-ID: <Pine.LNX.4.44.0304141116020.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Apr 2003, Roman Zippel wrote:
> 
> Linus, if you still want to go for a single block device major, this patch 
> is bad idea (at least in this form).

I disagree.

I think the single block-device major is a totally separate issue, and has 
nothing to do with allowing big device_t representations. I do not see why 
Andries patch would be anything else than infrastructure for future 
expansion.

		Linus

