Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318916AbSIIVEx>; Mon, 9 Sep 2002 17:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318920AbSIIVEw>; Mon, 9 Sep 2002 17:04:52 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:6128 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318916AbSIIVEs>; Mon, 9 Sep 2002 17:04:48 -0400
Subject: Re: LMbench2.0 results
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E17oRol-0006pi-00@starship>
References: <E17oRCu-0006pL-00@starship> <312431072.1031563589@[10.10.2.3]>
	 <E17oRol-0006pi-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 22:11:58 +0100
Message-Id: <1031605918.29792.55.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 17:55, Daniel Phillips wrote:
> You need to look at it from the other direction: how do the needs of a
> uniprocessor Clawhammer box differ from a Linksys adsl router?

I've advocated several times having a single config option for "fine
tuning" that sane people say "N" to and which if set lets you force
small hash sizes, disable block layer support and kill various other
'always needed' PC crap. Tell me - on a 4Mb embedded 386 running your
toaster do you really care if the TCP hash lookup is a little slower
than perfect scaling, and do you need a 64Kbyte mount hash ?

