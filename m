Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269542AbTHFPd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269555AbTHFPd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:33:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:14477 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269542AbTHFPd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:33:56 -0400
Date: Wed, 6 Aug 2003 08:33:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5/2.6 PCMCIA Issues
In-Reply-To: <20030806122340.B2094@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308060831490.4916-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Aug 2003, Russell King wrote:
> 
> Could the problem be PNP related?  I don't see much material change in
> the PNP layer between 2.5.70 and 2.5.71 though.

It definitely could be PnP-related, and it may well show up only on 
machines that have the yenta controller listed as an old-style pcmcia 
controller in the bios etc.

> Can other people try the CONFIG_YENTA=y, CONFIG_I82365=y, CONFIG_PNP=y
> and report their results (in particular the dmesg from boot, and whether
> the machine locks when they insert a card _after_ boot.)

Yes, getting more data-points would be good. Together with what kind of 
machine they have (not just what kind of yenta controller, but the bios 
and manufacturer..)

		Linus

