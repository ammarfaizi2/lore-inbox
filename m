Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267977AbTAHW4c>; Wed, 8 Jan 2003 17:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267976AbTAHW4c>; Wed, 8 Jan 2003 17:56:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13063 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267977AbTAHW4b>; Wed, 8 Jan 2003 17:56:31 -0500
Date: Wed, 8 Jan 2003 15:04:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: levon@movementarian.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
In-Reply-To: <20030108.143441.31155028.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0301081502270.7688-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Jan 2003, David S. Miller wrote:
>    
> Being that 32-bit is the primary (and in many ways, ONLY) userland for
> at least 2 64-bit kernel platforms, I think this does matter.

Nope.

System binaries match the kernel. It's as easy as that. So what if 90% of 
the user binaries use 32-bit mode because it's smaller and faster? We're 
talking about a system binary that is _very_ intimate with the kernel.

Just make it a compile-time option and be done with it. 

			Linus

