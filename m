Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSIIFKJ>; Mon, 9 Sep 2002 01:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSIIFKJ>; Mon, 9 Sep 2002 01:10:09 -0400
Received: from dsl-213-023-043-054.arcor-ip.net ([213.23.43.54]:43196 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316437AbSIIFKJ>;
	Mon, 9 Sep 2002 01:10:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 07:17:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: imran.badr@cavium.com, linux-kernel@vger.kernel.org
References: <E17nUee-0006Lc-00@starship> <E17oGD2-0006lP-00@starship> <20020908.220008.79156946.davem@redhat.com>
In-Reply-To: <20020908.220008.79156946.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oGvT-0006mX-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 07:00, David S. Miller wrote:
>    > 2) addresses within the main kernel image text/data/bss
>    
>    Yep.  MIPS's KSEG0 (a stupid design if there ever was one)
> 
> Actually, KSEG0 the most Linux friendly design in the world
> particularly in 64-bit mode.

That's easy to say until you try and work with it (I assume you have,
and forgot).  Just try to do a 3G/1G split on it, for example.

> I pine constantly for it appearing some day on a future UltraSPARC
> revision :-)

Don't wish too hard, you might get it ;-)

-- 
Daniel
