Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316820AbSGHHkx>; Mon, 8 Jul 2002 03:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGHHkw>; Mon, 8 Jul 2002 03:40:52 -0400
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:65308 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316820AbSGHHkw>; Mon, 8 Jul 2002 03:40:52 -0400
Date: Mon, 8 Jul 2002 09:43:15 +0100
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.5.25 (and LVM)
Message-ID: <20020708084315.GA1387@fib011235813.fsnet.co.uk>
References: <Pine.LNX.4.33.0207051646280.2484-100000@penguin.transmeta.com> <20020706135412.GA19227@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020706135412.GA19227@merlin.emma.line.org>
User-Agent: Mutt/1.3.28i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2002 at 03:54:12PM +0200, Matthias Andree wrote:
> On Fri, 05 Jul 2002, Linus Torvalds wrote:
> 
> > More merges all over the map - ppc, scsi, USB, kbuild, input drivers etc.
> 
> Did the LVM guys (are you listening?) tell anything if they were about
> to go fix the current 2.5 LVM breakage? Or does EVMS work on 2.5 instead?

I'll say this yet again:

Heinz Mauelshagen is maintaining LVM1.0.x on 2.4 kernels.  This is for
bug fixes only, no new features will be added.

Alasdair Kergon, Patrick Caulfield and myself are working on the more
generic device-mapper driver for both 2.4/2.5.  Initially we have
concentrated on 2.4, this driver is now very stable IMO (I would
certainly trust my data to it in preference to LVM1).

I will post a URL to the 2.5 patch at some point this week.

There is no intention to maintain the broken design that is LVM1 in
the 2.5 series - we do not have the spare resources to waste.

- Joe
