Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265598AbSKAE0k>; Thu, 31 Oct 2002 23:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265601AbSKAE0j>; Thu, 31 Oct 2002 23:26:39 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:39693 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265598AbSKAE0h>; Thu, 31 Oct 2002 23:26:37 -0500
Date: Fri, 1 Nov 2002 04:33:04 +0000
From: John Levon <levon@movementarian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
Message-ID: <20021101043304.GA7421@compsoc.man.ac.uk>
References: <20021019002645.GA16882@compsoc.man.ac.uk> <20021018.172327.11877875.davem@redhat.com> <20021019003415.GA17016@compsoc.man.ac.uk> <20021018.173128.11570989.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018.173128.11570989.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 05:31:28PM -0700, David S. Miller wrote:

> That would be a great way to do this portably.
> 
> I suspect oprofile won't be the only situation where this value
> would be useful, perhaps /proc/sys/kernel/pointer_size?

The problem is this would trivially break cross-compilation. Would it
not be better to stick something in the glibc's bits/types.h
per-platform ?

Not that I particularly fancy going near glibc...

regards
john

-- 
"My first thought was I don't have any makeup. How will I survive
without my makeup ? My second thought was I didn't have any identification.
Who am I ?"
	- Earthquake victim
