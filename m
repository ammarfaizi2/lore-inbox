Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbUCAAkf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 19:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbUCAAkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 19:40:35 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28852 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262200AbUCAAk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 19:40:29 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>, Matt Mackall <mpm@selenic.com>,
       Christophe Saout <christophe@saout.de>
Subject: Re: Worrisome IDE PIO transfers...
Date: Mon, 1 Mar 2004 01:47:47 +0100
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <4041232C.7030305@pobox.com> <20040229015041.GQ3883@waste.org> <40415152.8040205@pobox.com>
In-Reply-To: <40415152.8040205@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403010147.47808.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 of February 2004 03:41, Jeff Garzik wrote:
> Matt Mackall wrote:
> > On Sun, Feb 29, 2004 at 01:21:30AM +0100, Bartlomiej Zolnierkiewicz wrote:
> >>I like Alan's idea to use loopback instead of "bswap".
> >
> > Or, more likely, device mapper.
>
> Somehow I doubt anybody cares enough to write a whole driver just for
> this unlikely case.

http://www.kernel.org/pub/linux/kernel/people/bart/dm-byteswap-2.6.4-rc1.patch

Guess what's this? :)

[ Not that I care so much but I always wanted to learn more about
  device-mapper and crypto API. ]

It is simply a stripped down dm-crypt.c, so all credits go to Christophe.
I have tested it quickly with loop device and it seems to work.

Bartlomiej

