Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135641AbRDXOas>; Tue, 24 Apr 2001 10:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135651AbRDXOai>; Tue, 24 Apr 2001 10:30:38 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:26518 "HELO
	vega.digitel2002.hu") by vger.kernel.org with SMTP
	id <S135641AbRDXOaV>; Tue, 24 Apr 2001 10:30:21 -0400
Date: Tue, 24 Apr 2001 16:30:09 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
Message-ID: <20010424163009.A7197@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <Pine.GSO.4.21.0104240939120.6992-100000@weyl.math.psu.edu> <E14s3du-00029R-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14s3du-00029R-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 24, 2001 at 03:18:11PM +0100
X-Operating-System: vega Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 03:18:11PM +0100, Alan Cox wrote:
> > On Tue, 24 Apr 2001, Mohammad A. Haque wrote:
> > > Correct. <1024 requires root to bind to the port.
> > ... And nothing says that it should be done by daemon itself.
> 
> Or that you shouldnt let inetd do it for you
> And that you shouldn't drop the capabilities except that bind
> 
> It is possible to implement the entire mail system without anything running
> as root but xinetd.

Or even without xinetd. Just use local port forwarding eg 2525 -> 25, and
use port 2525 as SMTP port in your MTA. I've succeed to setup such a
configuration.

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]---------[ lgb@lgb.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
