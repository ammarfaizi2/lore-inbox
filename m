Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319213AbSH2R6V>; Thu, 29 Aug 2002 13:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319215AbSH2R6V>; Thu, 29 Aug 2002 13:58:21 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:4358 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S319213AbSH2R6U>; Thu, 29 Aug 2002 13:58:20 -0400
Date: Thu, 29 Aug 2002 13:02:43 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <Pine.LNX.4.10.10208291006070.24156-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0208291246310.13200-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Andre Hedrick wrote:

> 
> That host does have a flag check on the primary channel.
> The Seconday has been observed and many people have verified the second
> channel works okay in 48-bit.
> 
> If you have a system which has a 28-bit limited host, and it has been
> openly discussed on lkml for many months, why would one not use the
> jumpon.exe from maxtor to prevent such problems.

First, I'm new to lkml.  I did search the recent archives for
information on this topic, hoping that if it was a new problem it would
have shown up here.  Since the trouble for me began with
2.4.20-pre4-ac1, I did not search that far back.

I have never used "jumpon.exe" from Maxtor.  I don't even know what it
is (yet, I'm sure I'm going to find out awful quick now...).  When I set
up the system, it "just worked" from day 1 with the existing IDE driver
in the 2.4.19-preX series so I had no reason to go looking for issues
like this.


> 
> What I want is details from the last kernel you booted and worked, because
> I am positive AC's code does the correct thing.  I was one of the first
> people to find the 48-bit bomb in that asic during prototype of the large
> drive technology.

I don't doubt that it worked at some point.  It had to have worked, 
otherwise my hardware would never have worked at all at any time.  The 
fact is that the system was stable for several months; I had installed a 
full Debian setup on that hard drive, while attached to that controller, 
and dumped tens of GB to it over that time without incident.  The 
trouble happened when I updated the kernel to 2.4.20-pre4-ac1.

The previous kernel I had booted was 2.4.19-ac4, configured similarly
(copied its .config forward to build 2.4.20-pre4-ac1).  And before that,
I had run 2.4.19-pre10-ac2 without any IDE problems.


> 
> So please add more details, and regardless this is a semi-development
> thread and nobody else has reported this error.

I'll add more details as I learn them, but right now I must point out:

The same hardware configuration ran 2.4.19-ac4 just fine.  The only
change to the system was booting the newer kernel.  No hardware changes,
no BIOS updates, nothing else.  Whatever went wrong got introduced
somewhere between that version and 2.4.20-pre4-ac1.

Unfortunately as I said originally, all the gory details "burned in the 
fire" so I have precious little else to offer.

I will go back further in lkml and get up to speed on what happened back 
then with the "48 bit bomb", and I will look into your references about 
"28-bit limited host" and jumpon.exe.

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

