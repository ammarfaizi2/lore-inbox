Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262097AbREVQMp>; Tue, 22 May 2001 12:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbREVQMe>; Tue, 22 May 2001 12:12:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3554 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262020AbREVQMV>;
	Tue, 22 May 2001 12:12:21 -0400
Date: Tue, 22 May 2001 12:12:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <Pine.LNX.4.30.0105221104070.19818-100000@waste.org>
Message-ID: <Pine.GSO.4.21.0105221209130.15685-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 May 2001, Oliver Xymoron wrote:

> Because foo_ is a throwback to the days when C compilers had a single
> namespace for all structure elements, not a readability aid. If you need
> foo_ to know what type of structure you're futzing with, you need to name
> your variables better.

Not always. If the thing is used all over the tree, it'd better be
greppable. I hate the foo->de stuff - it's not localized and it's
impossible to grep for.

