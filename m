Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbUBJAgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUBJAgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:36:15 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45025 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265471AbUBJAcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 19:32:09 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Willy Tarreau <willy@w.ods.org>, Athol Mullen <athol@idl.net.au>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Date: Tue, 10 Feb 2004 01:37:32 +0100
User-Agent: KMail/1.5.3
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1mtPj-7oQ-3@gated-at.bofh.it> <20040208073151.GC29363@alpha.home.local> <200402100110.26513.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402100110.26513.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402100137.32804.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 of February 2004 01:10, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 08 of February 2004 08:31, Willy Tarreau wrote:
> > On Sun, Feb 08, 2004 at 11:45:18AM +1100, Athol Mullen wrote:
> > > Before I modified eighty_ninty_three(), it returning 0 caused the
> > > _indicated_ mode to drop to UDMA33.  Check in /proc/ide/piix to see
> > > what mode the driver tells you.  IIRC (could be wrong), dmesg and
> > > hdparm both believe it to be in UDMA33 while the init code and
> > > /proc/ide/piix both showed it as UDMA5.
>
> So host recognizes 80-wires cable correctly, but drive doesn't.
> eighty_ninty_three() is for checking _drive_ side.

It is for both host and drive sides.
I should have read my mail before hitting SEND button. ;-)

