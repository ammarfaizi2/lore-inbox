Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269040AbUIBUff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269040AbUIBUff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269023AbUIBUeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:34:04 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:14464 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S269041AbUIBUcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:32:22 -0400
Date: Thu, 2 Sep 2004 13:32:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nathan Bryant <nbryant@optonline.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
Message-ID: <20040902203213.GA7256@taniwha.stupidest.org>
References: <20040902192820.GA6427@taniwha.stupidest.org> <20040902193454.GI5492@holomorphy.com> <20040902194739.GA6673@taniwha.stupidest.org> <41377EF6.4010902@optonline.net> <1094153248.5809.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094153248.5809.41.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 08:27:28PM +0100, Alan Cox wrote:

> It also happens on a lot of hardware on the odd instance a non IRQ
> code path clears down an interrupt just as its being raised. IDE
> does it now and then for example.

So how about we just remove those printk statements completely then?
I've never heard of a single need for them other than reporting things
we don't really care about....
