Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTJJQEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTJJQEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:04:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:61334 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262848AbTJJQCn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:02:43 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thom Borton <borton@phys.ethz.ch>, Dave Jones <davej@redhat.com>
Subject: Re: PCMCIA CD-ROM does not work
Date: Fri, 10 Oct 2003 18:06:32 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200310101652.53796.borton@phys.ethz.ch> <20031010150916.GA32600@redhat.com> <200310101744.30827.borton@phys.ethz.ch>
In-Reply-To: <200310101744.30827.borton@phys.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310101806.32137.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 10 of October 2003 17:44, Thom Borton wrote:
> Thanks a lot, I tried the parameters
> 	ide1=0x386,0x180 pci=off
> and it did not work. pci=off seems to have broken quite a lot (fb,
> jogdial, ...). Just leaving it away and just having ide1=0x386,0x180
> didn't help the CD-ROM drive either.
>
> I am now compiling the 2.4.19/20/21 kernels to try to figure out,
> where it broke. I have some suspicion that it happened when ide-cs.c
> was moved to legacy from drivers/ide.

I suspect yenta.

> BTW, if it's legacy, what replaces it?

It's legacy not obsolete.

--bartlomiej

