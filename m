Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbUCTPqV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbUCTPqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:46:20 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35469 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263449AbUCTPqT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:46:19 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 16:54:42 +0100
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
References: <20040319153554.GC2933@suse.de> <200403200224.14055.bzolnier@elka.pw.edu.pl> <405C1B1C.4000804@pobox.com>
In-Reply-To: <405C1B1C.4000804@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403201654.42274.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 11:21, Jeff Garzik wrote:
> > I wish it was so simple.  Here is an example to make it clear:
> >
> > model: WDC WD800JB-00CRA1 firmware: 17.07W77
> > word 0x83 is 4b01, word 0x86 is 0x0801
> >
> > and drive of course supports CACHE FLUSH command.
>
> What ATA revision?

ATA-5

> Sending down opcodes because they will "probably" work isn't the best
> idea in the world...

It isn't but spec says that devices should abort unknown commands. 8)

Bartlomiej

