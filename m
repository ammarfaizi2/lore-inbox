Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTJJJ0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 05:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTJJJYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 05:24:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20642 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262774AbTJJJYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 05:24:06 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
Subject: Re: Serverworks CSB5 IDE-DMA Problem (2.4 and 2.6)
Date: Fri, 10 Oct 2003 11:27:43 +0200
User-Agent: KMail/1.5.4
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310091634330.3040-100000@logos.cnet> <200310092329.00445.bzolnier@elka.pw.edu.pl> <3F86746C.6040704@madness.at>
In-Reply-To: <3F86746C.6040704@madness.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310101127.43601.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 of October 2003 10:57, Stefan Kaltenbrunner wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > 2.4.18, 2.4.19 w/o APIC and ACPI
>
> ok 2.4.18 (dmesg at http://www.kaltenbrunner.cc/files/dmesg2418.txt)
> seems to work better(although not as fast as I would like to have it)
> but I suspect that:
>
> ide1: Speed warnings UDMA 3/4/5 is not functional.
> ide0: Speed warnings UDMA 3/4/5 is not functional.
>
> is quite interesting - if these UDMA-modes do not work reliable - why do
> they get enabled with later kernels(not that I would have a problem with
> getting UDMA > 2 working *g*) ?

2.4.22 has 80-pin cable dedetecion for more vendors.
You can try passing "ide0=ata66 ide1=ata66" boot options.

--bartlomiej

