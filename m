Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTJITm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTJITm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:42:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25046 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262464AbTJITmz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:42:55 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Serverworks CSB5 IDE-DMA Problem (2.4 and 2.6)
Date: Thu, 9 Oct 2003 21:46:17 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, <mm-mailinglist@madness.at>
References: <Pine.LNX.4.44.0310091634330.3040-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310091634330.3040-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310092146.17695.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 of October 2003 21:35, Marcelo Tosatti wrote:
> Sorry, I screwed up, again.
>
> Thats me asking, not Bart. Duh.

Hehe.

> On Thu, 9 Oct 2003, Bartlomiej Zolnierkiewicz wrote:
> > Bart,
> >
> > Do you have any idea ?
> >
> > Wild guess: Disable APIC?

APIC problem should be fixed, but yes it's better to disable ACPI.

These "timeout due to drive busy" needs to be resolved.
I don't remember seeing it et all in earlier 2.4.x kernels.
I am now searching through mail archive to find some starting point
(ie. 2.4.18 works, 2.4.20 doesn't etc.).

--bartlomiej

