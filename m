Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbTCOMf5>; Sat, 15 Mar 2003 07:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbTCOMf5>; Sat, 15 Mar 2003 07:35:57 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:45970 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S261434AbTCOMfz>; Sat, 15 Mar 2003 07:35:55 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Chris Fowler <cfowler@outpostsentinel.com>
Cc: Robert White <rwhite@casabyte.com>, Ed Vance <EdV@macrolink.com>,
       "'Linux PPP'" <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1047598241.5292.2.camel@hp.outpostsentinel.com>
References: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com>
	 <1047598241.5292.2.camel@hp.outpostsentinel.com>
Message-Id: <1047732394.20703.10.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (dwmw2) (Preview Release)
Date: 15 Mar 2003 12:46:35 +0000
Subject: RE: RS485 communication
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 23:30, Chris Fowler wrote:
> Are you saying that for him to to use PPPD that he will have to write a
> program that will run on a master and tell all the slave nodes when they
> can transmit their data.  In this case it would be ppp data.  Hopfully
> in block sizes that are at least the size of the MTU ppp is running.

You don't _need_ a master, although it's often an easy answer.

You can have a token-bus arrangement like ARCnet does. In fact, the
ARCnet data sheets describing how it works may make interesting reading.

-- 
dwmw2


