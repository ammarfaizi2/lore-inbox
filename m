Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbTDNTXG (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbTDNTXG (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:23:06 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:43016 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263939AbTDNTXD (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:23:03 -0400
Date: Mon, 14 Apr 2003 21:34:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: Joel Becker <Joel.Becker@oracle.com>, <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <Pine.LNX.4.44.0304141056450.19302-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304142128560.12110-100000@serv>
References: <Pine.LNX.4.44.0304141056450.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Apr 2003, Linus Torvalds wrote:

> And the 32+32 split is what the new maximum would be, so ..
> 
> The 16+16 split is not strictly necessary, but Andries pointed out to me
> that there are filesystems etc external storage that only support a 32-bit
> opaque dev_t, so we'd need to marshall the device number _some_ way for
> them anyway, and having a standard way to do that is better than having
> everybody come up with their own variations.
> 
> (My prefernce for the 32-bit version would be 12+20 bits, but it's not a
> very strong one, and it doesn't really matter for the kernel proper, so I
> think Andries who has been tirelessly working on this for five years or
> more gets the final say on it).

If you want to argue this way, I urge to ask Al as well, as he did most of 
the hard work to remove the block device limits. For some reason everyone 
likes to disagree with me, but I would accept his judgement.

bye, Roman


