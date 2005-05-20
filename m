Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVETXjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVETXjL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 19:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVETXjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 19:39:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25020 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261601AbVETXjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 19:39:09 -0400
Date: Sat, 21 May 2005 00:39:03 +0100 (BST)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Jon Smirl <jonsmirl@gmail.com>
cc: linux-os@analogic.com, Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <9e4733910505201421cf36902@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0505210037290.18193@pentafluge.infradead.org>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com> 
 <Pine.LNX.4.58.0505201259560.2206@ppc970.osdl.org> 
 <Pine.LNX.4.61.0505201612360.6833@chaos.analogic.com>
 <9e4733910505201421cf36902@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, and I didn't want to. However a customer wants some status to
> > be always displayed in the upper-right-hand corner of a 4x5 LCD
> > with a tiny CPU board.
> 
> The console implements a tiny terminal emulator. Does the emulator
> implement the escape sequence for locking an unscrollable line at the
> top of the screen? If so lock the line, write your info there, and the
> rest of the display will work like normal.

Yes it does. This is how the penguin is displayed without scrolling in the 
framebuffer console.

