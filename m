Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274255AbRJEWRW>; Fri, 5 Oct 2001 18:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274249AbRJEWRM>; Fri, 5 Oct 2001 18:17:12 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:44008 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S274248AbRJEWRF>; Fri, 5 Oct 2001 18:17:05 -0400
Date: Fri, 5 Oct 2001 23:17:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: jamey.hicks@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.11-pre4/drivers/mtd/bootldr.c does not compile
Message-ID: <20011005231732.B19985@flint.arm.linux.org.uk>
In-Reply-To: <200110052048.NAA19993@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110052048.NAA19993@baldur.yggdrasil.com>; from adam@yggdrasil.com on Fri, Oct 05, 2001 at 01:48:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 01:48:42PM -0700, Adam J. Richter wrote:
> 	Attempting to compile linux-2.4.11-pre4/drivers/mtd/bootldr.c
> fails with a bunch of compiler errors, including a complaint that
> "struct tag" is not defined anywhere.  Presumably this is the result
> of an incompletely applied patch.

Firstly, its ARM only.  Secondly, Compaq decided that a partition table in
flash isn't a good idea, so they're passing it from the boot loader, which
is a set of tagged lists.

Unfortunately, they haven't even sent me a patch to add the entries into
the ARM tree, so even I have to reverse this from my MTD update. ;(

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

