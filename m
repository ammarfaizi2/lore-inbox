Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVCZXfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVCZXfM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 18:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVCZXfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 18:35:12 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:57495 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261346AbVCZXfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 18:35:08 -0500
In-Reply-To: <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost> <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com> <1111825958.6293.28.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7d96f2772f942f802890c50801c4f5f8@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Jesper Juhl <juhl-lkml@dif.dk>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
Date: Sun, 27 Mar 2005 00:34:12 +0100
To: linux-os@analogic.com
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-03-27, at 00:21, linux-os wrote:
>
> Always, always, a call will be more expensive than a branch
> on condition. It's impossible to be otherwise. A call requires
> that the return address be written to memory (the stack),
> using register indirection (the stack-pointer).
>
Needless to say that there are enough architectures out there, which 
don't even
have something like an explicit call as separate assembler 
instruction...

