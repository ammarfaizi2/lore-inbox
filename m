Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVEPRGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVEPRGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVEPRGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:06:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21130 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261760AbVEPRF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:05:59 -0400
Date: Mon, 16 May 2005 18:42:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mark Lord <lkml@rtr.ca>, Denis Vlasenko <vda@ilport.com.ua>,
       mhw@wittsend.com, linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
Message-ID: <20050516164230.GA1762@elf.ucw.cz>
References: <1116001207.5239.38.camel@localhost.localdomain> <200505152200.26432.vda@ilport.com.ua> <4287E807.6070502@rtr.ca> <1116235789.25594.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116235789.25594.19.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > All flashcards (other than dumb "smart media" cards) have integrated
> > NAND controllers which perform automatic page/block remapping and
> > which implement various wear-leveling algorithms. Rewriting "Sector 0"
> > 10000 times probably only writes once to the first sector of a 1GB card.
> > The other writes are spread around the rest of the card, and remapped
> > logically by the integrated controller.
> 
> Assuming the firmware of the card is written with a modicum of clue,
> this is true. It's not clear how valid that assumption is, in the
> general case. There are reports of cards behaving as if they have almost
> no wear levelling at all.

I have seen card marked "3.3V/5V", but it only really worked on
3.3V. Linux used 5V and quickly killed it.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
