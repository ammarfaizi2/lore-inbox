Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbTBFWVk>; Thu, 6 Feb 2003 17:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267649AbTBFWVk>; Thu, 6 Feb 2003 17:21:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267503AbTBFWVj>; Thu, 6 Feb 2003 17:21:39 -0500
Date: Thu, 6 Feb 2003 14:26:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steven Cole <elenstev@mesatop.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
In-Reply-To: <1044569551.14310.311.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.4.44.0302061424110.14297-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Feb 2003, Steven Cole wrote:
> 
> So, since this uses ex instead of vi ;), here is something to fix
> the spelling of definite and separate throughout the tree.

You've not tried this with a tree that has source control (either CVS, BK
or RCS) have you? It looks like it corrupts the SCM too.

I don't really mind getting scripts occasionally to do things, but they 
had better be "obviously fool-proof" for it to really be worth-while. 
Mostly it's easier to just get a diff, even if in this case the (broken) 
script is just 3 lines, and the diff would likely be 700+ lines.

		Linus

