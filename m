Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUDGRgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbUDGRgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:36:15 -0400
Received: from penguin.gktech.net ([207.170.199.12]:41733 "EHLO gktech.net")
	by vger.kernel.org with ESMTP id S263861AbUDGRgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:36:13 -0400
Date: Wed, 7 Apr 2004 10:36:05 -0700 (PDT)
From: Bryan Koschmann - GKT <gktnews@gktech.net>
To: Andi Kleen <ak@muc.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: amd64 questions
In-Reply-To: <m3zn9o58n0.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.30.0404071015000.17695-100000@penguin.gktech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, Andi Kleen wrote:
> Debian seems to have some unique problems in the way they handle AMD64
> compared to other distributions. I would not trust what you read
> there, they make it much more complicated than it really is. The right
> forum would have been discuss@x86-64.org

I was hoping that was the case. I wouldn't think the only way would be so
"rigged". I will check out the x86-64 list, thanks for that.

> It's that way. You just need a 64bit capable cross compiler to compile
> the kernel, which is not that difficult to build from sources. You can also
> find binaries for that at
> ftp://ftp.suse.com/pub/suse/x86_64/supplementary/CrossTools/8.1-i386/
> (usable with rpm2cpio on non RPM distributions). Then you can
> cross compile the kernel in the normal way with
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-

Great, much better than I had hoped. I always build from source, I'm
guessing I can find something on freshmeat.

> A few programs (namely iptables and ipsec tools) need to be used
> as 64bit programs because the 32bit emulation doesn't work for them.
> ipchains works though.

Okay, thanks for the tip, that probably would have gotten me when I
started installing.

Thanks for all the information Andi, it was extremely helpful!

	Bryan

