Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbUJXXDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUJXXDG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 19:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUJXXCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 19:02:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:11724 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261612AbUJXXCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 19:02:00 -0400
Subject: Re: [2.6.10-rc1] Segmentation fault in program "X"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Thomas Meyer <thomas.mey3r@arcor.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410241323140.13209@ppc970.osdl.org>
References: <417B6A17.8010904@arcor.de>
	 <200410241313.31151.vda@port.imtp.ilyichevsk.odessa.ua>
	 <417BF02F.20704@arcor.de>
	 <Pine.LNX.4.58.0410241323140.13209@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1098658803.11740.206.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Oct 2004 09:00:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 06:24, Linus Torvalds wrote:

> > Signal SIGSEGV happens while doing sys function
> > "ioctl(5, FBIOBLANK <unfinished ...>"
> > 
> > seems to be some changes between 2.6.9 and 2.6.10-rc1 in file "fbmem.c"
> 
> Do you have radeon hardware? Is there any oops in your logs?

A Oops log would be useful...

I don't see anything, are you sure he is using radeonfb ? Look at the
fix posted by Tony Dapalas today fixing a possible Oops on blank for
fbdev's that have no blank() callback ...

Ben.


