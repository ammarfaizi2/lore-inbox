Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUBSRDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUBSRDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:03:33 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26614 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267385AbUBSRDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:03:30 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: root@chaos.analogic.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] remove MAKEDEV scripts from scripts/
Date: Thu, 19 Feb 2004 18:09:44 +0100
User-Agent: KMail/1.5.3
Cc: akpm@osdl.org, Linux kernel <linux-kernel@vger.kernel.org>
References: <20040219161306.GA30620@lst.de> <Pine.LNX.4.53.0402191119480.520@chaos> <200402191751.16652.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402191751.16652.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191809.44418.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 of February 2004 17:51, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 19 of February 2004 17:25, Richard B. Johnson wrote:
> > On Thu, 19 Feb 2004, Christoph Hellwig wrote:
> > > makedev is a userland issue, and the distros already take care of ide
> > > and sound.  scripts/ OTOH is supposed to hold utils needed for building
> > > the kernel tree which the above certainly aren't.
> >
> > If that's true, i.e., /scripts contains _only_ utilities for building
> > the kernel tree, then you make another directory to contain MAKEDEV.ide.
> > You don't simply delete it because you don't want it there. This
> > script substitutes for, and works in conjunction with a primary source
> > of documentation, ../Documentation/ide.txt
>
> Thanks, for catching this!
>
> Christoph, please remove MAKEDEV.ide references from Documentation/ide.txt
> 8).

Ugh, there are much more references to MAKEDEV in Documentation/ dir.

