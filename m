Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130089AbRBZBPG>; Sun, 25 Feb 2001 20:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130096AbRBZBO5>; Sun, 25 Feb 2001 20:14:57 -0500
Received: from hera.cwi.nl ([192.16.191.8]:56290 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130089AbRBZBOr>;
	Sun, 25 Feb 2001 20:14:47 -0500
Date: Mon, 26 Feb 2001 02:14:10 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102260114.CAA10722.aeb@vlet.cwi.nl>
To: Werner.Almesberger@epfl.ch, viro@math.psu.edu
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, we probably want to add mount --move <old> <new> - atomically moving
> a subtree from one place to another. Code is there, we just need to
> decide on API. Andries?

Since we already have "mount --bind olddir newdir" this is not
an unreasonable extension of the mount(8) syntax.
And since the kernel is no longer so interested in coeds as
some former mount author, we have lots of free bits.
There are even old bits.

#define MS_MOVE	0x2000

Andries
