Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287840AbSABOIY>; Wed, 2 Jan 2002 09:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287832AbSABOFh>; Wed, 2 Jan 2002 09:05:37 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:22691 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S287833AbSABODr>; Wed, 2 Jan 2002 09:03:47 -0500
Date: Wed, 2 Jan 2002 15:03:29 +0100 (CET)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Klaus Zerwes <kzerwes@web.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bug ?
In-Reply-To: <3C30A9F0.3070603@web.de>
Message-Id: <Pine.LNX.4.33.0201021502000.13557-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001, Klaus Zerwes wrote:

> My PC hangs sporadicaly (every 2 weeks) after heavy Network traffic.
> I tried to work around the problem by changing the NIC (dmfe >
> realtek, using new driver 8139too), but it din't help.

The RealTek 8139 is a bad choice, I had the same effect on one of our
servers until I replaced it with a NE2000. I think this is related to
busmaster DMA.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

