Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267453AbUBSRxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUBSRxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:53:44 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62716 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267446AbUBSRxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:53:43 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] remove MAKEDEV scripts from scripts/
Date: Thu, 19 Feb 2004 18:59:55 +0100
User-Agent: KMail/1.5.3
Cc: root@chaos.analogic.com, akpm@osdl.org,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <20040219161306.GA30620@lst.de> <200402191809.44418.bzolnier@elka.pw.edu.pl> <20040219170451.GA31763@lst.de>
In-Reply-To: <20040219170451.GA31763@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191859.55179.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 of February 2004 18:04, Christoph Hellwig wrote:
> On Thu, Feb 19, 2004 at 06:09:44PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > Christoph, please remove MAKEDEV.ide references from
> > > Documentation/ide.txt 8).
> >
> > Ugh, there are much more references to MAKEDEV in Documentation/ dir.
>
> MAKEDEV is okay, it's the script in /dev used to create device nodes.

I know but this is inconsistent - "makedev is a userland issue, and the
distros already take care of ide and sound. ".  Same goes for MAKEDEV.

We should at least try to remove some these references during 2.6.
(and make people aware about udev, random major/minor numbers, etc.).

