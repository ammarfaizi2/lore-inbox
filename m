Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267986AbTAHXyr>; Wed, 8 Jan 2003 18:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267992AbTAHXyq>; Wed, 8 Jan 2003 18:54:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36875 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267986AbTAHXyq>; Wed, 8 Jan 2003 18:54:46 -0500
Date: Wed, 8 Jan 2003 16:02:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: levon@movementarian.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
In-Reply-To: <20030108.150303.130044451.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0301081601300.1096-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Jan 2003, David S. Miller wrote:
>    
> oprofile can perfectly legitimately be used to monitor 32-bit binaries
> running on under a 64-bit kernel environment.  In fact I expect such
> exercises to be very instructive.  Anton Blanchard has done this
> already on ppc64.

That's not the _point_.

Oprofile is a system binary, and as such you might as well use a 64-bit 
oprofile.

Of y ou can use am /etc/systype file that contains information.

BUT WE DON'T ADD CRAP TO THE KERNEL!

That's final.

		Linus

