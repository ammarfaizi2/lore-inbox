Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293495AbSB1R1b>; Thu, 28 Feb 2002 12:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293525AbSB1RYu>; Thu, 28 Feb 2002 12:24:50 -0500
Received: from edu.joroinen.fi ([195.156.135.125]:39177 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S293634AbSB1RWl> convert rfc822-to-8bit;
	Thu, 28 Feb 2002 12:22:41 -0500
Date: Thu, 28 Feb 2002 19:22:39 +0200 (EET)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <jgarzik@mandrakesoft.com>,
        <linux-net@vger.kernel.org>
Subject: Re: [BETA-0.92] Third test release of Tigon3 driver
In-Reply-To: <20020227.055102.75257130.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0202281917270.10668-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Feb 2002, David S. Miller wrote:

>
> In the usual place:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3-0.92.patch.gz
>
> Three changes of note:
>
> [FEATURE] Yay, real HW acceleration hooks in the 802.1q VLAN layer.
> 	  Tigon3 takes advantage of it.
> [BUG FIX] Let tg3_read_partno fail, some boards do not provide the
>           information and it isn't critical to the operation of the
> 	  driver.
> [BUG FIX] Minor bug in ETHTOOL_GREGS length handling.
> [CLEANUP] Use netif_carrier_{ok,on,off}() to keep track of link state.
>
> If people with real VLANs can try to get the HW acceleration stuff
> working, I'd really appreciate it.  Especially the person who (GASP)
> wanted us to put the tasteless NICE stuff into our driver. :-)
>

Heh, I've never looked at the NICE-code.. I just found it working OK for
me :)

Anyway, I'm going to test this code after a while so I can be sure it
_should_ work (I have only one production system where I can test this so
I can't use very buggy drivers in it :)



> Adding support to the Acenic driver should be pretty easy and I'll
> try to do that before catching some sleep.  Jeff could also probably
> cook up something quick for the e1000.
>

That would be nice, a common way for hw-vlans is a good thing.

Intel has also their own (kludgy?) way of doing hw-vlans in the current
driver?


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

