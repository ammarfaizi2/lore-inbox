Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263252AbSKEGJ3>; Tue, 5 Nov 2002 01:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264775AbSKEGJ3>; Tue, 5 Nov 2002 01:09:29 -0500
Received: from rth.ninka.net ([216.101.162.244]:29413 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S263252AbSKEGJ2>;
	Tue, 5 Nov 2002 01:09:28 -0500
Subject: Re: Linux v2.5.46
From: "David S. Miller" <davem@redhat.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: george anzinger <george@mvista.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211042035330.20254-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0211042035330.20254-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 22:30:34 -0800
Message-Id: <1036477834.31982.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 18:37, Kai Germaschewski wrote:
> On Mon, 4 Nov 2002, george anzinger wrote:
> 
> > I think we need a newer objcopy :(
> 
> Alternatively, use this patch. (It's not really needed to force people to 
> upgrade binutils when ld can do the job, as it e.g. does in 
> arch/i386/boot/compressed/Makefile already).

Does not work for me at all on sparc64, it complains that *.gz has an
unknown file format.

Why not just hexdump the thing into an array of char foo.c file,
then compile that.

