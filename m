Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbTL3B33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbTL3B33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:29:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5066 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264141AbTL3B31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:29:27 -0500
Date: Tue, 30 Dec 2003 01:27:15 +0000
From: Dave Jones <davej@redhat.com>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230012715.GA30369@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thomas Molina <tmolina@cablespeed.com>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain> <1072741422.25741.67.camel@nosferatu.lan> <Pine.LNX.4.58.0312291913270.5835@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312291913270.5835@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 07:17:23PM -0500, Thomas Molina wrote:

 > > >  UDMA modes: udma0 udma1 *udma2 udma3 udma4
 > > >  AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 > > >  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:
 > > Any reason it is currently set to udma2 where it support udma4 ?
 > 
 > Not really.  The question was what mode the disk was running in.  This is 
 > what it defaults to.  This is a laptop drive that only runs at 5400RPM.  
 > Would changing the mode to udma4 make a dramatic difference?  

It's not uncommon for a laptop to have a hard disk which supports
higher DMA modes than what the IDE chipset supports.
My aging Intel 440BX based VAIO has a disk in the same configuration
as yours, supports udma4, but chipset only goes up to udma2.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
