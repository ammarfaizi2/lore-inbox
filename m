Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbSITRem>; Fri, 20 Sep 2002 13:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbSITRem>; Fri, 20 Sep 2002 13:34:42 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:32009 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261653AbSITRek>; Fri, 20 Sep 2002 13:34:40 -0400
Date: Fri, 20 Sep 2002 19:39:44 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ServerWorks CSB5 in recent -ac
Message-ID: <20020920173944.GG14336@louise.pinerecords.com>
References: <20020920173125.GE14336@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920173125.GE14336@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 1 day, 18:11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... and makes the driver spit the following upon initial read attempts:
> 
> hdd: DMA interrupt recovery
> hdd: lost interrupt
> hdd: status timeout: status=0xd0 { Busy }
> hdd: status timeout: error=0x00
> hdd: DMA disabled
> hdd: drive not ready for command
> hdd: ATAPI reset complete
> 
> ... after which everything works ook.  Contrary to what the driver
> reports, DMA doesn't get disabled.

Okay, I lied, it does get disabled.  So at least you've got something
left to fix. :)

T.
