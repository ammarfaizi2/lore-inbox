Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315383AbSEGIch>; Tue, 7 May 2002 04:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315385AbSEGIcg>; Tue, 7 May 2002 04:32:36 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:53961
	"EHLO awak") by vger.kernel.org with ESMTP id <S315383AbSEGIcf>;
	Tue, 7 May 2002 04:32:35 -0400
Subject: Re: 3c59x: LK1.1.17 gives No MII transceivers found
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andrew Morton <akpm@zip.com.au>
Cc: Kees Bakker <kees.bakker@altium.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD78BDC.B6ED1BA5@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 07 May 2002 10:32:19 +0200
Message-Id: <1020760341.17626.55.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking of MII ... I have some RTL8139(A|B|C) network cards, which can
do 10/100Mbps. However the driver doesn't seem to advertise MII
registers.
Do these cards have MII registers ?
Anyone knows how I can switch them to 100Mbps ?

	Xav

[xav@bip:~]$ /sbin/mii-tool -v -v
eth0: 10 Mbit, half duplex, no link
  registers for MII PHY 32: 
    0000 0000 0000 0000 0000 0000 0000 0000
    0000 0000 0000 0000 0000 0000 0000 0000
    0000 0000 0000 0000 0000 0000 0000 0000
    0000 0000 0000 0000 0000 0000 0000 0000
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   10 Mbit, half duplex
  basic status: no link
  capabilities:
  advertising: 



