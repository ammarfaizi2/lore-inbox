Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267829AbTB1NZS>; Fri, 28 Feb 2003 08:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267871AbTB1NZS>; Fri, 28 Feb 2003 08:25:18 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:52999 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S267879AbTB1NYr>;
	Fri, 28 Feb 2003 08:24:47 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Monniaux <David.Monniaux@ens.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise PDC 20376
References: <3E5ED648.5080509@ens.fr>
	<1046438573.16599.11.camel@irongate.swansea.linux.org.uk>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 28 Feb 2003 14:35:00 +0100
In-Reply-To: Alan Cox's message of "28 Feb 2003 13:22:53 +0000"
Message-ID: <yw1xheao34vv.fsf@lakritspuck.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Fri, 2003-02-28 at 03:23, David Monniaux wrote:
> > Is anybody (Andre?) working on a driver for the Promise PDC 20376 Serial 
> > ATA / RAID controller?
> 
> No. The SII is supported and the HPT with SATA bridges should work. Some
> informal discussion has occurred with two other vendors who will be releasing
> SATA products in time.
> 
> It is probably possible to reverse engineer the 20376 since I suspect it will
> behave like the older devices but with the registers memory mapped.

As I suppose you already know, the 20375 driver acts like a scsi
driver.  I ran it through objdump -d and got ~20000 instructions.  I
doubt anyone would want to analyse that load, even if it were legal.

-- 
Måns Rullgård
mru@users.sf.net
