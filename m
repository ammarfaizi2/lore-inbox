Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318032AbSHCWRo>; Sat, 3 Aug 2002 18:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHCWRo>; Sat, 3 Aug 2002 18:17:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9718 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318032AbSHCWRn>; Sat, 3 Aug 2002 18:17:43 -0400
Subject: Re: No Subject
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Pawel Kot <pkot@linuxnews.pl>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0208040010520.696-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0208040010520.696-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 00:38:00 +0100
Message-Id: <1028417880.1760.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 23:16, Bartlomiej Zolnierkiewicz wrote:
> Just rethough it. What if chipset is in compatibility mode?
> Like VIA with base addresses set to 0?

If we found a register that was marked as unassigned with a size then we
would map it to a PCI address. That would go for BAR0-3 on any PCI IDE
device attached to the south bridge.

What problems does that cause for the VIA stuff ?

