Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbTLHDEE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 22:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbTLHDEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 22:04:04 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41157 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265309AbTLHDEC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 22:04:02 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bob <recbo@nishanet.com>
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
Date: Mon, 8 Dec 2003 04:06:02 +0100
User-Agent: KMail/1.5.4
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com> <1070671068.3972.6.camel@athlonxp.bradney.info> <3FD3EB1A.2060600@nishanet.com>
In-Reply-To: <3FD3EB1A.2060600@nishanet.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312080406.02369.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 of December 2003 04:08, Bob wrote:
> >Sounds great.. maybe you have come across something. Yes, the CPU
> >Disconnect function arrived in your BIOS in revision of 2003/03/27
> >"6.Adds"CPU Disconnect Function" to adjust C1 disconnects. The Chipset
> >does not support C2 disconnect; thus, disable C2 function."
> >
> >For me though.. Im on an ASUS A7N8X Deluxe v2 BIOS 1007. From what I can
> >see the CPU Disconnect isnt even in the Uber BIOS 1007 for this ASUS
> >that has been discussed.
> >
> >Craig
>
> I don't have that in MSI K7N2 MCP2-T near the
> agp and fsb spread spectrum items or anywhere
> else.

Use athcool:
	http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#athcool
or apply kernel patch (2.4 and 2.6 versions were posted already).

--bart

