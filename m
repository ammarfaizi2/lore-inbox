Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUBQXmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266771AbUBQXmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:42:49 -0500
Received: from pop.gmx.net ([213.165.64.20]:12441 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266684AbUBQXmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:42:47 -0500
X-Authenticated: #20450766
Date: Wed, 18 Feb 2004 00:42:40 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Brad Cramer <bcramer@callahanfuneralhome.com>
cc: "'Guennadi Liakhovetski'" <g.liakhovetski@gmx.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
In-Reply-To: <004a01c3f59c$f192aa10$6501a8c0@office>
Message-ID: <Pine.LNX.4.44.0402180030570.2588-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Brad Cramer wrote:

> sym0: <895> rev 0x1 at pci 0000:00:0f.0 irq 11
> sym0: Tekram NVRAM, ID 7, Fast-40, SE, NO parity
> sym0: SCSI BUS has been reset.
> sym0: SCSI BUS mode change from SE to SE.
> sym0: SCSI BUS has been reset.
> scsi0 : sym-2.1.18f
>   Vendor: SEAGATE   Model: SX4234514         Rev: 9E21
>   Type:   Direct-Access                      ANSI SCSI revision: 02

Isn't this your drive?

> sym0:0:0: tagged command queuing enabled, command queue depth 4.
>   Vendor: PIONEER   Model: DVD-ROM DVD-303R  Rev: 2.00
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: IOMEGA    Model: ZIP 100           Rev: J.02
>   Type:   Direct-Access                      ANSI SCSI revision: 02
>   Vendor: SONY      Model: SDT-5000          Rev: 3.26
>   Type:   Sequential-Access                  ANSI SCSI revision: 02

If not, could you also post the relevant part of your 2.4 boot log for
comparison? If it is, maybe just the enumeration has changed, so, that now
you have to mount it under a different letter?

Guennadi
---
Guennadi Liakhovetski


