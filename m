Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293061AbSB1V63>; Thu, 28 Feb 2002 16:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310132AbSB1V4k>; Thu, 28 Feb 2002 16:56:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56082 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292934AbSB1VzE>; Thu, 28 Feb 2002 16:55:04 -0500
Date: Thu, 28 Feb 2002 16:53:38 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: texas <texas@ludd.luth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
In-Reply-To: <Pine.GSU.4.33.0202272021090.23682-100000@father.ludd.luth.se>
Message-ID: <Pine.LNX.3.96.1020228165054.2006A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, texas wrote:

> We recently invested in a new database server (MySQL), a Dual P4 Xeon (2 x
> 2GHz Prestonia, 1GB RDRAM) system, it's mainboard is a Supermicro P4DCE+
> based on the i860 chipset.

After boot disable screen blanking with "setterm -blank 0" and see if that
helps. Seems some video cards do something odd at blanking time (or
perhaps you're using the BIOS blanking option). Only seems to happen with
SMP, and I got this from IBM support, so I doubt it's totally a folk tale.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

