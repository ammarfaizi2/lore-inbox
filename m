Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319064AbSIJAgO>; Mon, 9 Sep 2002 20:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319065AbSIJAgO>; Mon, 9 Sep 2002 20:36:14 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:20217
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319064AbSIJAgN>; Mon, 9 Sep 2002 20:36:13 -0400
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0209091727370.2069-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0209091727370.2069-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 01:40:39 +0100
Message-Id: <1031618439.31787.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 01:30, Linus Torvalds wrote:
> We might want to add some "weaker" form of BUG_ON() for sanity checks that 
> aren't life-threatening (ie a "CHECK(a == b)" kind of debug facility) that 
> would be prettier than doing printk's and show_trace(), and that would 
> also be easier to disable for production kernels (not that I personally 
> much believe in disabling debugging like that - if it really isn't needed 
> it should be removed, not disabled).

I'd have thought you may well want the reverse. If the user didnt pick
the kernel debugging, don't die on software check option you want to
blow up. If they are debugging or its < 2.6.0-rc1 you want it to show
the stack and keep going


