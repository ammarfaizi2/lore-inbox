Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289395AbSAJLBa>; Thu, 10 Jan 2002 06:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289393AbSAJLBU>; Thu, 10 Jan 2002 06:01:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19720 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289392AbSAJLBE>; Thu, 10 Jan 2002 06:01:04 -0500
Subject: Re: xfree86 compilation failure due to naming conflict (linux 2.4.17, Xfree86 4.1.0)
To: jon-sven@frisurf.no (jon svendsen)
Date: Thu, 10 Jan 2002 11:12:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020110054555.C4116@fig.aubernet> from "jon svendsen" at Jan 10, 2002 05:45:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Od8U-000456-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd supply a patch, but I'm not familiar enough with the relationship 
> between the kernel and xfree86 drivers to know what the proper solution 
> would be, nor am I certain if the modification should happen in linux 
> or in xfree86. Hopefully I have supplied enough information facilitiate 
> a fairly simple solution.

Fix the XFree86 side I think. Its not shown up because DRI as shipped in
4.1 didn't actually work for the SIS cards
