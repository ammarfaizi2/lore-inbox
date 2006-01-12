Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbWALUEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbWALUEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWALUEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:04:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41603 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161227AbWALUEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:04:13 -0500
Date: Thu, 12 Jan 2006 12:04:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.15-$SHA1: VT <-> X sometimes odd
In-Reply-To: <Pine.LNX.4.64.0601121119100.3535@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0601121201520.3535@g5.osdl.org>
References: <20060110162305.GA7886@mipter.zuzino.mipt.ru> <43C4F114.9070308@gmail.com>
 <20060111153822.GA7879@mipter.zuzino.mipt.ru> <20060112192856.GA7938@mipter.zuzino.mipt.ru>
 <Pine.LNX.4.64.0601121119100.3535@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Jan 2006, Linus Torvalds wrote:
>
> or if that isn't it, and you have an IDE drive, can you try if the 
> appended trivial patch makes a difference?

I just pushed out a commit that reverts the IDE softirq request 
completion, so if you pull a recent enough git tree, and you see that 
revert (by Jens), the patch in the previous email won't apply, but it 
won't be needed either.

		Linus
