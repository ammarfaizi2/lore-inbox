Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSHCWuM>; Sat, 3 Aug 2002 18:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318034AbSHCWuM>; Sat, 3 Aug 2002 18:50:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8438 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S318017AbSHCWuL>; Sat, 3 Aug 2002 18:50:11 -0400
Date: Sun, 4 Aug 2002 00:53:33 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pawel Kot <pkot@linuxnews.pl>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No Subject
In-Reply-To: <1028417880.1760.52.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0208040049140.696-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Aug 2002, Alan Cox wrote:

> On Sat, 2002-08-03 at 23:16, Bartlomiej Zolnierkiewicz wrote:
> > Just rethough it. What if chipset is in compatibility mode?
> > Like VIA with base addresses set to 0?
>
> If we found a register that was marked as unassigned with a size then we
> would map it to a PCI address. That would go for BAR0-3 on any PCI IDE
> device attached to the south bridge.
>
> What problems does that cause for the VIA stuff ?

In compatibility mode IDE chipsets have IO at legacy ISA ports and
PCI_BASE_ADDRESS0-3 are set to them or to zero (at least on VIA).
And they can't be programmed to any other ports (unless native mode).

I am just asking if it can cause some problems.

--
Bartlomiej

