Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274987AbTHLC0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274988AbTHLC0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:26:11 -0400
Received: from EPRONET.01.dios.net ([65.222.230.105]:15775 "EHLO
	mail.eproinet.com") by vger.kernel.org with ESMTP id S274987AbTHLC0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:26:09 -0400
Date: Mon, 11 Aug 2003 21:52:49 -0400 (EDT)
From: "Mark W. Alexander" <slash@dotnetslash.net>
To: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
Cc: Norbert Preining <preining@logic.at>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 cannot mount root fs
In-Reply-To: <20030811222134.GA10481@www.13thfloor.at>
Message-ID: <Pine.LNX.4.44.0308112148110.20222-100000@llave.eproinet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Herbert [iso-8859-1] Pötzl wrote:

> > hdg: max request size 128 KiB
> > hdg: 16514064 sectors (8455 MB) w/467KiB Cache, CHS=16383/16/63,
> > UDMA(33)
> >         hdg: hdg1
> > hdc: ATAPI 40X DVD-ROM drive, 128kB Cache, UDMA(33)
> > Uniform CD-ROM driver Revision: 3.31
> > hdd: ATAPI 40X CD-ROM ....
> > Console ...
> > ...
> > blabla
> > ...
> > VFS: cannot mount ...

Are you using an initrd image and if so, are you using the new
initrd-tools?  I was having this problem before upgrading
initrd-tools. 2.6 does not support compressed ROM initrd images, so
even though it sees your partitions it can't load the _initial_ root.

mwa
--
Mark W. Alexander
slash@dotnetslash.net

