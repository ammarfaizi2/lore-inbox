Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271064AbRHOG2Q>; Wed, 15 Aug 2001 02:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271065AbRHOG2F>; Wed, 15 Aug 2001 02:28:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39645 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271064AbRHOG2A>;
	Wed, 15 Aug 2001 02:28:00 -0400
Date: Wed, 15 Aug 2001 02:28:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Magnus Naeslund(f)" <mag@fbab.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <3e4101c12550$50f242b0$020a0a0a@totalmef>
Message-ID: <Pine.GSO.4.21.0108150225120.13928-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Aug 2001, Magnus Naeslund(f) wrote:

> The more serious part of my little alloc adventure is much more dangerous:
> 
> Whattaheck happened to my resources?
> I _still_ can't log in to that box as a luser (root works).

May be memory fragmentation. You need an order 1 allocation for fork(), just
to allocate task_struct...

