Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261964AbSIPOVf>; Mon, 16 Sep 2002 10:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbSIPOVf>; Mon, 16 Sep 2002 10:21:35 -0400
Received: from b114225.adsl.hansenet.de ([62.109.114.225]:21252 "EHLO
	smaug.lan.local") by vger.kernel.org with ESMTP id <S261964AbSIPOVf>;
	Mon, 16 Sep 2002 10:21:35 -0400
Message-ID: <XFMail.20020916162624.f.hinzmann@hamburg.de>
X-Mailer: XFMail 1.5.2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <1032179595.1191.0.camel@irongate.swansea.linux.org.uk>
Date: Mon, 16 Sep 2002 16:26:24 +0200 (CEST)
From: Florian Hinzmann <f.hinzmann@hamburg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
       Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16-Sep-2002 Alan Cox wrote:
> On Mon, 2002-09-16 at 12:17, Florian Hinzmann wrote:
>> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
>> kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
>> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> 
> Which is the drive reporting a physical media error

Which seems to exist only while using the named combinations of DMA access
and kernel versions. While using i.e. 2.4.19 without DMA I can access the same data,
dd the whole disk to /dev/null or run badblock checks without finding
any physical media errors.

2.4.19 should complain, too, if there is a physical error indeed, right?


  Regards
      Florian



--
  Florian Hinzmann                         private: f.hinzmann@hamburg.de
                                            Debian: fh@debian.org
PGP Key / ID: 1024D/B4071A65
Fingerprint : F9AB 00C1 3E3A 8125 DD3F  DF1C DF79 A374 B407 1A65
