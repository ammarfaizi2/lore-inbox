Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUFMRcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUFMRcI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 13:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUFMRcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 13:32:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41924 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265232AbUFMRcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 13:32:05 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Sun, 13 Jun 2004 19:36:08 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200406111750.30312.bzolnier@elka.pw.edu.pl> <20040612103453.GB26482@infradead.org>
In-Reply-To: <20040612103453.GB26482@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406131936.08338.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 of June 2004 12:34, Christoph Hellwig wrote:
> On Fri, Jun 11, 2004 at 05:50:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Probably some drivers are still missed because I changed only
> > these drivers that I knew that there are PCI cards using them.
> >
> > If you know about PCI cards using other drivers please speak up.
>
> IMHO the PCI ->probe methods should always be __devinit.  It's rather
> hard to make sure they're never every hotplugged in any way, especially
> with the dynamic id adding via sysfs thing.

I generally agree but IMO it makes no sense for i.e. piix.c.

