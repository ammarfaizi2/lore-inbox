Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753942AbWKZXG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbWKZXG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbWKZXG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:06:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753942AbWKZXGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:06:25 -0500
Date: Sun, 26 Nov 2006 15:06:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Build breakage ...
In-Reply-To: <20061126224928.GA22285@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org>
References: <20061126224928.GA22285@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Nov 2006, Ralf Baechle wrote:
> 
> That sort of patches really should go to /dev/null so short before a release.

Yeah, I don't think it was worth it.

That said, Alexey did check it more than most patches like this get 
checked (ie checking allmodconfig on i386, x86_64, alpha, arm), so it's a 
bit unlucky that MIPS got bitten by this - it was not a badly tested 
patch per se.

Does the obvious fix (to include <linux/kernel.h> in irqflags.h) fix it 
for you?

		Linus
