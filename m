Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269046AbUIBUdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269046AbUIBUdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUIBUa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:30:27 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28561 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269038AbUIBU3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:29:52 -0400
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Chris Wedgwood <cw@f00f.org>, William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <41377EF6.4010902@optonline.net>
References: <20040902192820.GA6427@taniwha.stupidest.org>
	 <20040902193454.GI5492@holomorphy.com>
	 <20040902194739.GA6673@taniwha.stupidest.org>
	 <41377EF6.4010902@optonline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094153248.5809.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 20:27:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 21:13, Nathan Bryant wrote:
> Right, spurious interrupts aren't a big deal on i386. They happen now 
> and then with some devices because some hardware timing tolerances are a 
> little too tight. 

It also happens on a lot of hardware on the odd instance a non IRQ code
path clears down an interrupt just as its being raised. IDE does it now
and then for example.

