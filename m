Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264067AbRFERsI>; Tue, 5 Jun 2001 13:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264061AbRFERr7>; Tue, 5 Jun 2001 13:47:59 -0400
Received: from sbcs.sunysb.edu ([130.245.1.15]:55292 "EHLO sbcs.cs.sunysb.edu")
	by vger.kernel.org with ESMTP id <S264064AbRFERrt>;
	Tue, 5 Jun 2001 13:47:49 -0400
Date: Tue, 5 Jun 2001 13:42:50 -0400 (EDT)
From: Srikant Sharma <srikant@cs.sunysb.edu>
X-X-Sender: <srikant@sbtzi-cker>
To: John Jasen <jjasen1@umbc.edu>
cc: <slurn@verisign.com>, Keith Owens <kaos@ocs.com.au>,
        <linux-kernel@vger.kernel.org>, <kdb@oss.sgi.com>
Subject: Re: strange network hangs using kdb
In-Reply-To: <Pine.SGI.4.31L.02.0106051315370.11523908-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.GSO.4.33.0106051341220.22295-100000@sbtzi-cker>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you using eepro100 network cards ?
Because we have observed that many times when we enter kdb
the card on this machine goes crazy and starts pumping 8808 congestion
control packets and other cards stop sending data over the network.
try tcpdump and see if something like this is going on ..
--
Srikant



On Tue, 5 Jun 2001, John Jasen wrote:

> On Tue, 5 Jun 2001 slurn@verisign.com wrote:
>
> > Might the machine running kdb also be acting as a gateway or router
> > for the other boxen?  This would account for the lack of connectivity.
>
> Nope. No such luck. I _wish_ it was that easy. :)
>
> As for it being a network problem, it is -- and completely reproducable.
> Fire up kdb, and no-one receives packets. Otherwise, no problems occur --
> even when both systems are under heavy network load.
>
> --
> -- John E. Jasen (jjasen1@umbc.edu)
> -- In theory, theory and practise are the same. In practise, they aren't.
>
>

