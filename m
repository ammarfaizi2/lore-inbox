Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268648AbUHaXBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268648AbUHaXBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUHaW7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:59:33 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:18089 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268568AbUHaWzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:55:44 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Driver retries disk errors.
References: <20040830163931.GA4295@bitwizard.nl>
	<1093952715.32684.12.camel@localhost.localdomain>
	<20040831135403.GB2854@bitwizard.nl>
	<1093961570.597.2.camel@localhost.localdomain>
	<20040831155653.GD17261@harddisk-recovery.com>
	<1093965233.599.8.camel@localhost.localdomain>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 01 Sep 2004 00:55:40 +0200
In-Reply-To: <1093965233.599.8.camel@localhost.localdomain>
Message-ID: <m3isay9atv.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Retries also pop up in other less obvious cases and conveniently paper
> over a wide variety of timeouts, power management quirks and drives just
> having a random fit. Eight is probably excessive in all cases.
> 
> For non hard disk cases many devices do want and need retry.

For ripping CDs I'd prefer if the application could control retries
and not default to what the CD player prefers.

I have a CD, KLF -- Ultra Rare Tracks, and unfortunately someone I
borrowed it to managed to literally stomp on it, so the record has a
lot of scratches.  I would very much like to rip as much as possible
of this CD so that I can at least listen to part of it, but every time
I have tried the CD player just gets stuck in an endless retry loop.

The same thing happens when trying to rip a "copy controlled" CD,
which is also pretty irritating since this means that I can't rip my
Teddybears Stockholm CD and put the songs on my iPod.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
