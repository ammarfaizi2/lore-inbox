Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUKEWJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUKEWJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUKEWJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:09:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:42719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261225AbUKEWIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:08:52 -0500
Date: Fri, 5 Nov 2004 14:08:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Chris Wedgwood <cw@f00f.org>, Andries Brouwer <aebr@win.tue.nl>,
       Adam Heath <doogie@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
Message-ID: <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041105195045.GA16766@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Nov 2004, Grzegorz Kulewski wrote:
> 
> And using ramfs for anything else can easily lead to similar problems. So 
> I think we do not need ramfs. Am I wrong? [I understand that removing it 
> will not remove much code.]

ramfs is very useful as a minimal filesystem for showing what the VFS
interfaces are, and also (I believe) used in embedded environments, where
it's simply the smallest possible thing, and swap isn't available anyway.

You can just disable it if you don't want it..

		Linus
