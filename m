Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSFLOHI>; Wed, 12 Jun 2002 10:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317709AbSFLOHH>; Wed, 12 Jun 2002 10:07:07 -0400
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:30194 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317708AbSFLOHG>; Wed, 12 Jun 2002 10:07:06 -0400
Date: Tue, 11 Jun 2002 23:39:14 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
X-X-Sender: <becker@presario>
To: Matthew Hall <matt@ecsc.co.uk>
cc: Kernel <linux-kernel@vger.kernel.org>, <jgarzik@mandrakesoft.com>
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
In-Reply-To: <1023799395.3064.49.camel@smelly.dark.lan>
Message-ID: <Pine.LNX.4.33.0206112336340.2253-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 2002, Matthew Hall wrote:

> To: Kernel <linux-kernel@vger.kernel.org>
> Cc: becker@scyld.com, jgarzik@mandrakesoft.com
...
> I have been testing the D-Link DFE-580TX Quad channel server card (4
> port nic), on kernel 2.4.18 with little success.
>
> Attached are the appropriate results of dmesg, ifconfig, lspci and
> modules.conf; aswell as the results of the pci-testing tool found on
> scyld.com, however the card does not support mii testing, claiming to
> have no MII transceiver.

Please provide the full detection message.

It appears that you are using a driver that doesn't correctly read the
EEPROM, and has additional problems.  Try a current driver from
   http://www.scyld.com/network/ethercard.html
      ftp://www.scyld.com/pub/network/sundance.c
   http://www.scyld.com/network/updates.html

and run diagnostic program from
  http://www.scyld.com/diag/index.html


-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

