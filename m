Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135225AbRDRSnL>; Wed, 18 Apr 2001 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135249AbRDRSnB>; Wed, 18 Apr 2001 14:43:01 -0400
Received: from wet.kiss.uni-lj.si ([193.2.98.10]:25864 "EHLO
	wet.kiss.uni-lj.si") by vger.kernel.org with ESMTP
	id <S135225AbRDRSmu>; Wed, 18 Apr 2001 14:42:50 -0400
From: Rok Papez <rok.papez@kiss.uni-lj.si>
Reply-To: rok.papez@kiss.uni-lj.si
To: Craig Schlenter <craig@webtelecoms.co.za>
Subject: Re: TCP/IP problem on 2.2.18. Very big delay when pinging *local* interface (5x NIC, 18x IP).
Date: Wed, 18 Apr 2001 20:09:36 +0200
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01041611164102.00759@strader> <20010416113724.A30745@webtelecoms.co.za>
In-Reply-To: <20010416113724.A30745@webtelecoms.co.za>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01041820113900.07186@strader>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, 16 Apr 2001, you wrote:

> > When I boot Linux and ping a *local* IP address, it has a
> > very big delay. Flood ping works without a glitch, normal 
> > ping exhibits a big delay at the start but will eventualy
> > start working normally.
> 
> try ping -n IP_ADDRESS. Chances are your reverse DNS is unhappy for the
> IP's in question.

Yes.. that was it. Thank you.
I was sure if I specified IP it wasn't doing any NS lookups.. Silly me. :-(.

-- 
lp,
Rok.
