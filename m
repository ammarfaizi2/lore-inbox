Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUBQTRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266468AbUBQTRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:17:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:16787 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266464AbUBQTRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:17:41 -0500
X-Authenticated: #20450766
Date: Tue, 17 Feb 2004 20:17:01 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Brad Cramer <bcramer@callahanfuneralhome.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
In-Reply-To: <008401c3f572$6b72d330$6501a8c0@office>
Message-ID: <Pine.LNX.4.44.0402171937490.4978-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Brad Cramer wrote:

> Linux version 2.6.2 (root@bigdaddy) (gcc version 3.3.3 20040125 (prerelease)
> (Debian)) #1 Thu Feb 12 08:33:42 EST 2004

...

> 383MB HIGHMEM available.
> 896MB LOWMEM available.

...

> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

...

> Detected 1402.432 MHz processor.
> Using tsc for high-res timesource

...

> Memory: 1293316k/1310656k available (1941k kernel code, 16200k reserved,
> 831k data, 164k init, 393152k highmem)

...

> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm) processor stepping 04

Is this the complete log? Why did you decide that the problem is with SCSI
then? There should be some more stuff between this point and SCSI init. If
you really suspect SCSI, you could try disabling your controller-driver
and enable another one, then it should boot further and panic nixely
"unable to mount root-fs".

> 1,1           Top

This didn't belong to the log, did it?

Guennadi
---
Guennadi Liakhovetski


