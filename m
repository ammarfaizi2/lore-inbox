Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbRGSRZs>; Thu, 19 Jul 2001 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbRGSRZm>; Thu, 19 Jul 2001 13:25:42 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:22277 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S265480AbRGSRZB>;
	Thu, 19 Jul 2001 13:25:01 -0400
Date: Thu, 19 Jul 2001 19:24:57 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Cornel Ciocirlan <ctrl@rdsnet.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request for comments
Message-ID: <20010719192457.A9181@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.21.0107191757400.17990-100000@groove.rdsnet.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0107191757400.17990-100000@groove.rdsnet.ro>; from ctrl@rdsnet.ro on Thu, Jul 19, 2001 at 06:44:52PM +0300
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Cornel Ciocirlan <ctrl@rdsnet.ro> ecrit :
[heavy linux networking rewrite in sight]
> Is it useful at all ? Point b) above could be implemented in userspace
> (Actually I've done a basic skeleton a while ago). Are the others worth
> the trouble ?
> 
> What do you gurus think ?

* Are you sure of where the cycles are spent when routing >> 20kpps ?
I have always been told that the lack of polling/batch processing kills
the software router. 
* What against the (not widely used) CONFIG_NET_FASTROUTE ?
* <mantra> mpls is good </mantra> Did you browse mpls at www.ietf.org
(and sourceforge for the current state of mpls-linux) ?
* IANAG but it looks like a wait for 2.5 project btw.

-- 
Ueimor
