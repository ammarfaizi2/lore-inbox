Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316137AbSEJVxE>; Fri, 10 May 2002 17:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316138AbSEJVxD>; Fri, 10 May 2002 17:53:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4370 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316137AbSEJVxD>; Fri, 10 May 2002 17:53:03 -0400
Date: Fri, 10 May 2002 14:52:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution
In-Reply-To: <3CDC3D39.607D1923@mvista.com>
Message-ID: <Pine.LNX.4.33.0205101451120.22516-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 May 2002, george anzinger wrote:
> 
> should work.  So here is a solution that does all the above and does 
> NOT invade new name spaces:

Ok, looks fine, but I'd really rather move the "jiffies" linker games
into the per-architecture stuff, and get rid of the jiffies_at_jiffies_64 
games.

It's just one line per architecture, after all.

		Linus

