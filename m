Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUDIVJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUDIVJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 17:09:23 -0400
Received: from zeus.kernel.org ([204.152.189.113]:56471 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261764AbUDIVJV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 17:09:21 -0400
X-Authenticated: #20450766
Date: Fri, 9 Apr 2004 23:00:46 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Christian Roessner <info@roessner-net.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: AM53C974 driver missing in 2.6.5
In-Reply-To: <200404091807.48179.info@roessner-net.com>
Message-ID: <Pine.LNX.4.44.0404092252300.4445-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, 9 Apr 2004, Christian Roessner wrote:

> I found at Google that the AM53C974 was removed since 2.6.0. My problem is:
> This driver is the only one that ever worked (2.4 kernels) for my TEAC CD
> writer. The tmscsim doesn´t do its job and that has nothing to do with the
> latency thing with SCSI-2.
>
> Is there a chance you could put the AM53C974 back in the kernel? Otherwise I
> will not be able to burn CDs under linux anymore :-(

It is, of course, preferred to fix the tmscsim driver to work for you too.
If you describe your problem precisely, we could try solving it. There was
a discussion around 2.6.0 on the linux-scsi mailing list whether or not to
keep the AM53C974 driver, and it was decided not to, since the tmscsim
should completely replace it. However, I did write a simple patch that
allowed to compile and use AM53C974 under 2.6. I sent it to LKML on
30.10.03 with the subject "[PATCH] Re: AMD 53c974 SCSI driver in 2.6".
However, again, it would be preferred to improve tmscsim.

You might want to move this discussion to linux-scsi
(linux-scsi@vger.kernel.org).

Guennadi
---
Guennadi Liakhovetski




