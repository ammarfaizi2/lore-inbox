Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311580AbSCNKqZ>; Thu, 14 Mar 2002 05:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311581AbSCNKqP>; Thu, 14 Mar 2002 05:46:15 -0500
Received: from krynn.axis.se ([193.13.178.10]:25010 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S311580AbSCNKqH>;
	Thu, 14 Mar 2002 05:46:07 -0500
Date: Thu, 14 Mar 2002 11:43:22 +0100 (CET)
From: Bjorn Wesen <bjorn.wesen@axis.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
In-Reply-To: <3C901455.5000704@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203141139400.26308-100000@godzilla.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Jeff Garzik wrote:
> Tangential question, what's up with the prism2 driver?
> 
> It seems like everybody I meet these days has a wireless card which uses 
> the prism2 driver from linux-wlan.org.  And since I just got two of 
> these cards (D-Link DWL-650), I am strongly tempted to merge the driver 
> into the kernel.

Just a datapoint:

The orinico driver (already in the kernel) works fine with the DWL-650 card. 
Tried it some days ago.. not a very big field trial but I inserted the card 
and I got an eth0 from it and it worked, so thats the way I like it :)

On the other hand, the driver from linux-wlan (also for prism2-based cards) 
did not compile because it required the external pcmcia-cs source-code etc..
it was not really "drop and compile". Anyway, I'm just happy one of them 
worked :)

/Bjorn

