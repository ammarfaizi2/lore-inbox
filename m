Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261632AbTCOXhD>; Sat, 15 Mar 2003 18:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbTCOXhD>; Sat, 15 Mar 2003 18:37:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5084
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261622AbTCOXhB>; Sat, 15 Mar 2003 18:37:01 -0500
Subject: RE: RS485 communication
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Chris Fowler <cfowler@outpostsentinel.com>,
       Robert White <rwhite@casabyte.com>, Ed Vance <EdV@macrolink.com>,
       "'Linux PPP'" <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1047732394.20703.10.camel@imladris.demon.co.uk>
References: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com>
	 <1047598241.5292.2.camel@hp.outpostsentinel.com>
	 <1047732394.20703.10.camel@imladris.demon.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047776160.1327.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Mar 2003 00:56:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 12:46, David Woodhouse wrote:
> On Thu, 2003-03-13 at 23:30, Chris Fowler wrote:
> > Are you saying that for him to to use PPPD that he will have to write a
> > program that will run on a master and tell all the slave nodes when they
> > can transmit their data.  In this case it would be ppp data.  Hopfully
> > in block sizes that are at least the size of the MTU ppp is running.
> 
> You don't _need_ a master, although it's often an easy answer.
> 
> You can have a token-bus arrangement like ARCnet does. In fact, the
> ARCnet data sheets describing how it works may make interesting reading.

RS485 supports CDMA, thats more than enough to implement ppp nicely, all
you have to do is a little abuse in the app or driver layer to block
sending when carrier is asserted

