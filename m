Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRA0JtE>; Sat, 27 Jan 2001 04:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbRA0Jsy>; Sat, 27 Jan 2001 04:48:54 -0500
Received: from mail.zmailer.org ([194.252.70.162]:61451 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132447AbRA0Jsk>;
	Sat, 27 Jan 2001 04:48:40 -0500
Date: Sat, 27 Jan 2001 11:48:19 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010127114819.M25659@mea-ext.zmailer.org>
In-Reply-To: <980523239.30846@whiskey.enposte.net> <94sriq$4b7$1@whiskey.enposte.net> <20010126165913.D1432@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010126165913.D1432@alcove.wittsend.com>; from mhw@wittsend.com on Fri, Jan 26, 2001 at 04:59:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 04:59:13PM -0500, Michael H. Warfield wrote:
> 	No...  Microsoft learned, just two days ago, something that has
> been part of best practices for over 15 years.  Do NOT put all of your
> DNS servers on the same network!  The technical error may have triggered
> the meltdown but if they had distributed their DNS the way they were
> suppose to, it would have NOT taken them totally out.  It wasn't the
> technician's mistake.  It was the single point of failure (and subsequently
> the single point of attack).  He just triggered it.

   Nope, they didn't learn it yet.

   Although asking NS pointers from Microsoft's DNS servers shows
   a set Akamai's DNS servers along with MS' ones, those must be
   listed at .COM  for them to become used...

whois -h whois.internic.net  microsoft.com
...
   Record last updated on 24-Jan-2001.

   Domain servers in listed order:

   DNS4.CP.MSFT.NET             207.46.138.11
   DNS5.CP.MSFT.NET             207.46.138.12
   DNS6.CP.MSFT.NET             207.46.138.20
   DNS7.CP.MSFT.NET             207.46.138.21

> 	Mike
> -- 
>  Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
