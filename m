Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSGUXoY>; Sun, 21 Jul 2002 19:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSGUXoY>; Sun, 21 Jul 2002 19:44:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29452 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315266AbSGUXoX>; Sun, 21 Jul 2002 19:44:23 -0400
Date: Mon, 22 Jul 2002 00:47:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
Message-ID: <20020722004728.T26376@flint.arm.linux.org.uk>
References: <20020722004353.S26376@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207220143520.4084-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207220143520.4084-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jul 22, 2002 at 01:44:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 01:44:16AM +0200, Ingo Molnar wrote:
> On Mon, 22 Jul 2002, Russell King wrote:
> 
> > Actually its to cover the case where you have a floppy drive, and you've
> > booted the kernel from a floppy disk, and the kernel doesn't have the
> > floppy driver built in.  It turns the floppy drive off, cause there's
> > nothing else to do that.
> 
> this should then be done by the floppy boot code?

Sounds like a better idea to me.  Although I'm not one to try it out. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

