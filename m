Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266909AbRGOUGu>; Sun, 15 Jul 2001 16:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbRGOUGk>; Sun, 15 Jul 2001 16:06:40 -0400
Received: from beasley.gator.com ([63.197.87.202]:34059 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266909AbRGOUG0>; Sun, 15 Jul 2001 16:06:26 -0400
From: "George Bonser" <george@gator.com>
To: "Steve VanDevender" <stevev@efn.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
Date: Sun, 15 Jul 2001 13:10:56 -0700
Message-ID: <CHEKKPICCNOGICGMDODJAEGADKAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <15185.57310.203036.847687@tzadkiel.efn.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You do of course realize that your problem was caused by other people
> who probably have exactly the same attitude as you do -- they didn't
> care whether they were doing the right thing, they just slapped together
> something that worked, even if it did introduce way too many routing
> hops.  So you're introducing a kludge to counteract their kludge, and
> eventually this all turns into a big pile of kludges that doesn't work.

One other thing is that I have no proof that they are reaching that server
farm from a conventional web browser or conventional network. They might be
using some kind of cellular modem attached to a phone or some other wireless
access that might be making several hops to get the data to them. I simply
have no idea. All I know is increasing the default hop count makes it work
and that is good enough for me. If that person can access a Win2k web server
but not my Linux server, there might be a business case against using Linux.
Of course I can always manually bump the default TTL but not every admin of
a website will know to do that. I am just trying to help Linux gain the
maximum possible acceptance by working with the maximum possible number of
clients with the least amount of fuss.


