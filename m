Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUDSRAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUDSRAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:00:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43241 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261498AbUDSRAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:00:42 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] floppy98.c: use kernel min/max
Date: Mon, 19 Apr 2004 18:59:29 +0200
User-Agent: KMail/1.5.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, zwane@linuxpower.ca
References: <20040418194357.4cd02a06.rddunlap@osdl.org> <200404191414.15702.bzolnier@elka.pw.edu.pl> <20040419085116.1d8576a6.rddunlap@osdl.org>
In-Reply-To: <20040419085116.1d8576a6.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404191859.29846.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 of April 2004 17:51, Randy.Dunlap wrote:
> On Mon, 19 Apr 2004 14:14:15 +0200 Bartlomiej Zolnierkiewicz wrote:
> | Hi Randy,
> |
> | I wonder if PC9800 fixes are worth the hassle as PC9800 merge
> | (AFAIR first patch went into 2.5.50!) was never finished.
> |
> | I think somebody should fix it or we should just remove it completely.
>
> I agree -- completely, on all counts, and I'm trying to take that up
> with Osamu Tomita, but he hasn't replied to my emails.

:-(

> BTW, I have fixes for about 95% of all of the PC-9800 modules
> and can successfully build a PC-9800 kernel, with IDE, SCSI,

Cool, do you also have these patches?
http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.1/2045.html

BTW at least PC9800 IDE support needs reworking - it is one BIG hack

> speaker, etc.  However, I can't test it.  So I think that it is
> fixable, but if it's been abandoned, it can also be removed.

Yep, somebody needs to maintain it or at least report when it breaks.

Cheers,
Bartlomiej

