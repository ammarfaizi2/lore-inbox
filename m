Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129122AbRBCTDs>; Sat, 3 Feb 2001 14:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129489AbRBCTDi>; Sat, 3 Feb 2001 14:03:38 -0500
Received: from saloma.stu.rpi.edu ([128.113.199.230]:25865 "HELO
	incandescent.mp3revolution.net") by vger.kernel.org with SMTP
	id <S129122AbRBCTDV>; Sat, 3 Feb 2001 14:03:21 -0500
From: dilinger@mp3revolution.net
Date: Sat, 3 Feb 2001 14:03:16 -0500
To: David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: xirc2ps_cs driver timeouts/errors
Message-ID: <20010203140316.A17343@incandescent.mp3revolution.net>
In-Reply-To: <20010202235431.A16216@incandescent.mp3revolution.net> <20010202212040.A11161@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010202212040.A11161@sonic.net>; from dhinds@sonic.net on Fri, Feb 02, 2001 at 09:20:40PM -0800
X-Operating-System: Linux incandescent 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few minutes ago, I got the following:
Feb  3 13:09:10 pea kernel: UDP: short packet: 0/58

.. and the driver hung.  I had to reinsert the card to get
networking back.  This is after 10 hours of uptime, using
the patch i sent previously against 2.4.1's xirc2ps_cs.
So the answer is, yes, it happens w/ 3.1.24's driver.  Any
suggestions?

On Fri, Feb 02, 2001 at 09:20:40PM -0800, David Hinds wrote:
> 
> On Fri, Feb 02, 2001 at 11:54:31PM -0500, dilinger@mp3revolution.net wrote:
> > 
> > Each time I get a transmit timeout, or UDP: short packet error,
> > networking on my laptop seems to go down.  Reinsertion of the
> > card temporarily fixes it, and if I leave it long enough it
> > also fixes itself.
> 
> Does the same happen with a 2.2 kernel and the 3.1.24 PCMCIA drivers?
> There is a bug fix in the 3.1.24 xirc2ps_cs driver that hasn't been
> merged into the kernel tree yet.
> 
> -- Dave

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
