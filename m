Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbTHaScE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 14:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTHaScE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 14:32:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16563 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261513AbTHaScC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 14:32:02 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Petr Baudis <pasky@ucw.cz>
Subject: Re: IDE DMA breakage w/ 2.4.21+ and 2.6.0-test4(-mm4)
Date: Sun, 31 Aug 2003 20:32:47 +0200
User-Agent: KMail/1.5
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831161634.GA695@pasky.ji.cz> <1062352643.11140.0.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062352643.11140.0.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308312032.47638.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 of August 2003 19:57, Alan Cox wrote:
> On Sul, 2003-08-31 at 17:16, Petr Baudis wrote:
> >   Hello,
> >
> >   when upgrading from 2.4.20 to 2.4.22, I hit a strange problem - the
> > machine mysteriously freezed (totally, interrupts blocked) in few seconds
> > when I tried to do anything with the soundcard. It turned out to be a DMA
> > conflict between soundcard and disk, since it disappears when I disable
> > the (now defaultly on) DMA-by-default IDE option.
>
> Sound and IDE work together on my MVP3 board. Maybe your hardware is
> just broken.

Or maybe sound driver is doing some funny things (?).

--bartlomiej

