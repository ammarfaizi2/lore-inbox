Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283508AbRK3Fqd>; Fri, 30 Nov 2001 00:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283512AbRK3FqY>; Fri, 30 Nov 2001 00:46:24 -0500
Received: from queen.bee.lk ([203.143.12.182]:31890 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S283508AbRK3FqP>;
	Fri, 30 Nov 2001 00:46:15 -0500
Date: Fri, 30 Nov 2001 11:45:06 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: J Sloan <jjs@pobox.com>
Cc: Nathan Poznick <poznick@conwaycorp.net>,
        Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezed up with eepro100 module
Message-ID: <20011130114506.A4789@bee.lk>
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com> <20011129095107.A17457@conwaycorp.net> <3C070FEC.3602CB49@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C070FEC.3602CB49@pobox.com>; from jjs@pobox.com on Thu, Nov 29, 2001 at 08:49:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 08:49:48PM -0800, J Sloan wrote:
> Nathan Poznick wrote:
> 
> > Thus spake Sven Heinicke:
> > >
> > > The 2.4.16 kernel finally makes my clients happy with memory
> > > management.  The systems that froz up is a Dell of some sort or other
> > > with two 1Ghz Pentium IIIs and 4G of memory.  But, now I seems to be
> > > having ethernet problems.  With and eepro100 card:
> >
> > I've encountered the same problem, with the same hardware setup (I
> > believe it's a Dell 2400, or something like that), on 2.4.14+xfs.  For
> >
> > [...]
> 
> Using the e100 driver instead seemed to solve the
> problem on the dell servers here.

Has anybody got the same issue with non Dell machines?

I am running 2.4.16 on a Compaq proliant ML 370 without problems (machine has
been up for 2+ days with the new kernels, though).  Trafic is not very high.

The driver is built into the kernel.

/proc/pci shows

  Bus  0, device   2, function  0:
    Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 8).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xc4fff000 [0xc4ffffff].
      I/O at 0x2400 [0x243f].
      Non-prefetchable 32 bit memory at 0xc4e00000 [0xc4efffff].
  Bus  0, device   5, function  0:
    Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (#2) (rev 8).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xc4dfd000 [0xc4dfdfff].
      I/O at 0x2c00 [0x2c3f].
      Non-prefetchable 32 bit memory at 0xc4c00000 [0xc4cfffff].

Regards,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.16)

First Law of Bicycling:
	No matter which way you ride, it's uphill and against the wind.

