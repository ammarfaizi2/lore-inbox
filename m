Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265878AbRF3LSW>; Sat, 30 Jun 2001 07:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265882AbRF3LSM>; Sat, 30 Jun 2001 07:18:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26089 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265878AbRF3LR6>;
	Sat, 30 Jun 2001 07:17:58 -0400
Date: Sat, 30 Jun 2001 07:17:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Philips <philips@iph.to>
cc: linux-kernel@vger.kernel.org
Subject: Re: A Possible 2.5 Idea, maybe?
In-Reply-To: <3B3DB318.B799F4E3@iph.to>
Message-ID: <Pine.GSO.4.21.0106300713330.1200-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Jun 2001, Philips wrote:

> 	If I could choose what filesystem to run on / - it impact performance greatly

No, it doesn't. Most of lookups go outside of root and within root you
mostly deal with cached lookups from dcache (which doesn't give a damn for
fs type) and with page cache lookups for data (mostly in libc) (ditto).

[snip]

> 	This would be one little step toward the microkernel architecture (like Hurd).
> Good again :-)

	Hurd and architecture in one sentence? Uh-oh...

