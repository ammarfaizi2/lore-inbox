Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTL3BmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbTL3BmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:42:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11219 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263462AbTL3BmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:42:18 -0500
Date: Tue, 30 Dec 2003 01:40:11 +0000
From: Dave Jones <davej@redhat.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Thomas Molina <tmolina@cablespeed.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230014011.GB30369@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Thomas Molina <tmolina@cablespeed.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain> <1072741422.25741.67.camel@nosferatu.lan> <Pine.LNX.4.58.0312291913270.5835@localhost.localdomain> <20031230012715.GA30369@redhat.com> <1072748264.25741.79.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072748264.25741.79.camel@nosferatu.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 03:37:44AM +0200, Martin Schlemmer wrote:

 > > It's not uncommon for a laptop to have a hard disk which supports
 > > higher DMA modes than what the IDE chipset supports.
 > > My aging Intel 440BX based VAIO has a disk in the same configuration
 > > as yours, supports udma4, but chipset only goes up to udma2.
 > Right, or as somebody else pointed out, it might not be a 80-pin cable.
 > 
 > Lets rephrase - does it also run in udma2 mode with 2.4 ?

Yes, because the chipset is not capable of >udma2.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
