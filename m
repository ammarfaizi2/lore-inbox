Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVIXJ5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVIXJ5z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 05:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVIXJ5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 05:57:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31422 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751395AbVIXJ5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 05:57:51 -0400
Date: Tue, 1 Jan 2002 06:18:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Purdie <rpurdie@rpsys.net>, Mark Lord <liml@rtr.ca>,
       LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
Subject: Re: [RFC/BUG?] ide_cs's removable status
Message-ID: <20020101051811.GA8946@openzaurus.ucw.cz>
References: <1127319328.8542.57.camel@localhost.localdomain> <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca> <1127327243.18840.34.camel@localhost.localdomain> <1127328385.20660.45.camel@localhost.localdomain> <1127348289.18840.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127348289.18840.62.camel@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > CF slots have card detection and ide-cs will see a card removal event.
> > Have a look at ide_event() in ide-cs.c: CS_EVENT_CARD_INSERTION and
> > CS_EVENT_CARD_REMOVAL are what they say...
> 
> Not implemented on large numbers of adapters. Been there tried that,
> been 2.4 IDE maintainer.

How is CF flash card different from CF microdrive? AFAIK they are
not, so we may need to detect IBM microdrives as "is_flash"...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

