Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbUKEPlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUKEPlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 10:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUKEPlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 10:41:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:38533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261635AbUKEPlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 10:41:19 -0500
Date: Fri, 5 Nov 2004 07:41:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Adam Heath <doogie@debian.org>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <20041105014146.GA7397@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Nov 2004, Andries Brouwer wrote:
>
> [Ob l-k]
> 
> I have not yet investigated, but my (vanilla) 2.6.9
> has a mouse problem that my vanilla 2.6.8.1 does not have:
> it starts selecting text as soon as I touch it for the first
> time, as if the initialization created a fake mouse-down event.

USB? We have another bug that was just root-caused to USB initialization 
sending a "clear suspend" packet, which apparently confuses some devices.

> [old stuff]
> 
> > There are probably people even using linux-1.2.
> 
> # uname -a
> Linux knuth 1.2.11 #27 Sun Jul 30 03:39:01 MET DST 1995 i486
> 
> (486 DX/2, 66MHz, 8 MB)
> 
> -rw-r--r--   1 root     root       281572 Jul 30  1995 zImage-1.2.11
> -rw-r--r--   1 root     root       277476 Apr  1  1995 zImage-1.2.2

Ok, you da man. What do you use it for? Or is it just lying around for 
nostalgic reasons?

		Linus
