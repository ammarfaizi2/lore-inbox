Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317649AbSHHQqU>; Thu, 8 Aug 2002 12:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317653AbSHHQqU>; Thu, 8 Aug 2002 12:46:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50310 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317649AbSHHQp6>; Thu, 8 Aug 2002 12:45:58 -0400
Date: Thu, 8 Aug 2002 12:52:05 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Bryan K. Walton" <thisisnotmyid@tds.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with 1gb ddr memory sticks on linux
In-Reply-To: <20020808160456.GI16225@weccusa.org>
Message-ID: <Pine.LNX.3.95.1020808124904.1372A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Bryan K. Walton wrote:

> I have a box running Debian 3.0 with a Via C3 800mhz processor
> that slows to a crawl when I put in a 1GB stick of PC2100 DDR memory.
> 
> The board, a Gigabyte GA-6RX, supports this memory stick.
> My 2.4.18 kernel is compiled with High Memory support and linux and the
> bios see all of the memory.  However, the box is VERY slow.  It takes
> about 5 minutes to install .deb binary.  It took me 12 hours to compile
> the 2.4.18 kernel!
> 
> Here is what I have done to rule things out . . .
> 
> 1) The box runs FAST with M$ Windows 2000.
> 2) The box runs FAST when using identical kinds of memory but in
> quantities of 512MB or less.
> 3) The box runs slow with other linux distos also. (I tried Redhat 7.2)
> 
> It seems to me that the problem has something to do with the linux
> kernel and 1GB memory sticks.  Am I off base?
> 
> Anyone have any ideas?

Maybe, just maybe, you have a PCI-based disk-drive controller and,
maybe, just maybe, you are running out of address-space when you
install all that RAM, so the disk driver falls-back to PIO?

Try just one, 1GB stick. See if it works okay, then try two, etc.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

