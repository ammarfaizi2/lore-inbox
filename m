Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTGHMKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbTGHMKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:10:47 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:52615 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S265153AbTGHMKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:10:46 -0400
Date: Tue, 8 Jul 2003 14:25:19 +0200
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: siimage, 2.5.74 and irq 19: nobody cared!
Message-ID: <20030708122519.GA7098@traveler.cistron.net>
References: <Pine.SOL.4.30.0307081414260.12802-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.SOL.4.30.0307081414260.12802-100000@mion.elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Tue, Jul 08, 2003 at 14:16:26 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.07.08 14:16, Bartlomiej Zolnierkiewicz wrote:
> On Tue, 8 Jul 2003, Miquel van Smoorenburg wrote:
> 
> > I was running 2.5.72-mm2 on our transit usenet news server
> > (700 GB in/day and 1 TB out/day) which ran just fine, until I
> > had some ext3 corruption on the /news partition. I remember
> > having seen something about this in the -mm changelogs.
> >
> > So I tried 2.5.74 and 2.5.74-mm2, but with those kernels the
> > siimage.c driver doesn't work. The card is detected, but a bit
> > later in the boot process its IRQ is disabled and it won't work.
> > Log is below. As said, it worked fine with 2.5.72-mm2 (OK, needed
> > to enabled UDMA with hdparm, but other than that, no problems):
> 
> Hi,
> 
> Please send dmesg from 2.5.62-mm2 and 'lspci -vvv' output.

You mean dmesg and lspci -vvv output of both 2.5.72-mm2 and 2.5.74 ?
Will do, as soon as I have a chance to play with the system again.
It's a newsfeeder, a few minutes downtime is not a problem, but I
had some serious problems and it was down for 2 hours - now it needs
several hours to "catch up" before I can take it down again.

Mike.
