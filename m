Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSLILAn>; Mon, 9 Dec 2002 06:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSLILAm>; Mon, 9 Dec 2002 06:00:42 -0500
Received: from mail.ithnet.com ([217.64.64.8]:55813 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S265085AbSLILAm>;
	Mon, 9 Dec 2002 06:00:42 -0500
Date: Mon, 9 Dec 2002 12:08:14 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: ratz@drugphish.ch, willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: hidden interface (ARP) 2.4.20
Message-Id: <20021209120814.2eaaef29.skraw@ithnet.com>
In-Reply-To: <20021208170135.GA354@alpha.home.local>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>
	<1039124530.18881.0.camel@rth.ninka.net>
	<20021205140349.A5998@ns1.theoesters.com>
	<3DEFD845.1000600@drugphish.ch>
	<20021205154822.A6762@ns1.theoesters.com>
	<20021208170135.GA354@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2002 18:01:35 +0100
Willy Tarreau <willy@w.ods.org> wrote:

> > I guess it would really be a great help if someone did tests like Cons'
> > "overall performance" ones for network performance explicitly. Like e.g.
> > performance for various packet-sizes of all available protocol types,
> > possibly including NAT connections. We have no comparable figures at hand
> > right now, I guess.
> 
> Why not ?
> I've often been doing this to check the reliability of the network layer of
> kernels that I distribute. I often use Tux for this, because it can easily
> sustain 10k hits/s during months.

This is unfortunately not sufficient, not even close to. If you really want to
have a good idea what is going on you should as well check out what is happening
with packet sizes a lot smaller than 1500 (normal mtu). Check data rate an
packet loss with packet sizes around 80 bytes or so to get an idea what bothers
us :-)

-- 
Regards,
Stephan
