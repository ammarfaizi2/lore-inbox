Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSFJVCE>; Mon, 10 Jun 2002 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316250AbSFJVCD>; Mon, 10 Jun 2002 17:02:03 -0400
Received: from khms.westfalen.de ([62.153.201.243]:30630 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S316258AbSFJVBY>; Mon, 10 Jun 2002 17:01:24 -0400
Date: 10 Jun 2002 22:46:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: thunder@ngforever.de
cc: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Message-ID: <8QbwcRg1w-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0206100808180.6159-100000@hawkeye.luckynet.adm>
Subject: Re: [PATCH] Futex Asynchronous Interface
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thunder@ngforever.de (Thunder from the hill)  wrote on 10.06.02 in <Pine.LNX.4.44.0206100808180.6159-100000@hawkeye.luckynet.adm>:

> On Mon, 10 Jun 2002, Helge Hafting wrote:
> > ls /dev/net
> > eth0 eth1 eth2 ippp0
>
> What is it worth? You have a few more files which you can't do anything
> with, and ifconfig output is much more greppable etc.

Ifconfig output is *WHAT*?!

Ifconfig output, to be parsed by a script, is one of the shittiest  
interfaces possible.

Look at this, and then tell me again that "ifconfig output is much more  
greppable"!

# ifconfig eth0
eth0      Protokoll:Ethernet  Hardware Adresse 00:50:FC:0C:63:69
          inet Adresse:10.0.41.2  Bcast:10.255.255.255  Maske:255.255.255.0
          EtherTalk Phase 2 Adresse:65280/237
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:26841078 errors:4240 dropped:0 overruns:0 frame:0
          TX packets:26134055 errors:0 dropped:0 overruns:0 carrier:0
          Kollisionen:8481
          RX bytes:60708618 (57.8 MiB)  TX bytes:2654812652 (2.4 GiB)

# LANG= ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:50:FC:0C:63:69
          inet addr:10.0.41.2  Bcast:10.255.255.255  Mask:255.255.255.0
          EtherTalk Phase 2 addr:65280/237
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:26841182 errors:4240 dropped:0 overruns:0 frame:0
          TX packets:26134181 errors:0 dropped:0 overruns:0 carrier:0
          collisions:8481
          RX bytes:60727233 (57.9 MiB)  TX bytes:2654827939 (2.4 GiB)

#

Even rooting around in /proc is better than this!

> I remember these network devices from Solaris. There wasn't any good about
> them IIRC, the only sane way of working with them was to work around them,
> i.e. ignoring. Do you want a /dev/ignoreme directory?

I have no idea what Solaris did, nor do I necessarily want to know, but I  
*do* have experience with what Linux does, and I'm certainly not  
impressed.

Given that I've fairly often been irritated about not having these things  
be filesystem nodes, I'd expect there to *be* benefit in having them in  
the filesystem if this is done halfway reasonable.

MfG Kai
