Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263932AbRFHJGS>; Fri, 8 Jun 2001 05:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263934AbRFHJGI>; Fri, 8 Jun 2001 05:06:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26884 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263932AbRFHJF6>;
	Fri, 8 Jun 2001 05:05:58 -0400
Date: Fri, 8 Jun 2001 10:05:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, Patrick Mochel <mochel@transmeta.com>,
        Alan Cox <alan@redhat.com>, "David S. Miller" <davem@redhat.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>, Richard Henderson <rth@cygnus.com>,
        Kanoj Sarcar <kanoj@google.engr.sgi.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 32-bit dma memory zone
Message-ID: <20010608100521.A7923@flint.arm.linux.org.uk>
In-Reply-To: <20010607153119.H1522@suse.de> <Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jun 07, 2001 at 02:22:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 02:22:10PM -0700, Linus Torvalds wrote:
> So should we not try to have some nicer interface like
> ...

This would certainly be very useful for ARM.  For several machines,
we don't want the dma region starting at ram offset 0, but at some
offset into the memory space.  Your suggested interface allows for
this nicely.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

