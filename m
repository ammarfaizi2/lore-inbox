Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278803AbRKDFhw>; Sun, 4 Nov 2001 00:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278807AbRKDFhm>; Sun, 4 Nov 2001 00:37:42 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:30213 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S278803AbRKDFhb>;
	Sun, 4 Nov 2001 00:37:31 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111040536.fA45akb11558@saturn.cs.uml.edu>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
To: dalecki@evision.ag
Date: Sun, 4 Nov 2001 00:36:46 -0500 (EST)
Cc: viro@math.psu.edu (Alexander Viro), rusty@rustcorp.com.au (Rusty Russell),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <3BE29401.157394A5@evision-ventures.com> from "Martin Dalecki" at Nov 02, 2001 01:39:29 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:

> Bull shit. Standard policy is currently to keep crude old
> interfaces until no end of time. Here are some examples:
>
> /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  196005888 60133376 135872512        0  3280896 31088640
> Swap: 410255360        0 410255360
> MemTotal:       191412 kB
> MemFree:        132688 kB
> MemShared:           0 kB
> Buffers:          3204 kB
>
> The first lines could have gone 2 years ago.

Kill them in the 2.5.0 kernel.

> /proc/ksyms - this is duplicating a system call (and making stuff
> easier for intrusors)

This is still used by procps.
