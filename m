Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTKUHwK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 02:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTKUHwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 02:52:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:42666 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264329AbTKUHwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 02:52:08 -0500
Date: Thu, 20 Nov 2003 23:51:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nuno Silva <nuno.silva@vgertech.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ndiswrapper
In-Reply-To: <3FBDC30E.2090200@vgertech.com>
Message-ID: <Pine.LNX.4.44.0311202349010.13351-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Nov 2003, Nuno Silva wrote:
> 
> The good people at Cambridge made a (very nice) VMM that exploits 
> ring0/1/3 to let one machine run various kernels independently (the 
> kernels need to be ported to the xen arch).

This is what I alluded to a few lines later - saying that if you move the
driver down to ring1, then you should move _everything_ down to ring1 and
just leave a microkernel at ring0.

Now, I'm not big on microkernels, but a pure virtual machine abstraction
is at least not the distateful academic mental masturbation that we saw in 
the 80's.

		Linus

