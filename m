Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSKISjm>; Sat, 9 Nov 2002 13:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSKISjm>; Sat, 9 Nov 2002 13:39:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:26015 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262420AbSKISjl>; Sat, 9 Nov 2002 13:39:41 -0500
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211091308250.10475-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0211091308250.10475-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Nov 2002 19:10:13 +0000
Message-Id: <1036869013.20393.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-09 at 18:09, Zwane Mwaikambo wrote:
> > 2.4 was modified to printk a message that TSC was not disabled. This
> > does confuse people
> 
> This is all very confusing, notsc isnn't supposed to work with cpus with 
> TSCs?

User boots TSC only kernel
User gets problem
User reads docs and says "notsc"
User still has problem
User confused.

In the TSC only case printing a message that the TSC disable was not
possible is IMHO good


