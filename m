Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261603AbSJBA2Z>; Tue, 1 Oct 2002 20:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbSJBA2Z>; Tue, 1 Oct 2002 20:28:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261603AbSJBA2Y>; Tue, 1 Oct 2002 20:28:24 -0400
Date: Tue, 1 Oct 2002 17:35:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <20021001221421.A7762@infradead.org>
Message-ID: <Pine.LNX.4.33.0210011735100.4577-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Oct 2002, Christoph Hellwig wrote:
> 
> What about the 64bit sector_t (aka >2TB blockdevice) patches. 

I think we should do both 64-bit sector_t and 32-bit dev_t, although both 
of them depend on how horrible the code ends up being. Example patches?

		Linus

