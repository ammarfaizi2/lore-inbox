Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbUAJWw0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbUAJWw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:52:26 -0500
Received: from pop.gmx.net ([213.165.64.20]:42122 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265505AbUAJWwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:52:21 -0500
X-Authenticated: #20450766
Date: Sat, 10 Jan 2004 23:52:16 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <20040110223412.GC17845@matchmail.com>
Message-ID: <Pine.LNX.4.44.0401102343070.7120-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Mike Fedyk wrote:

> What version is the arm kernel you're running on the client, and where is it
> from?

2.4.19-rmk7, 24.4.21-rmk1-pxa1, 2.6.0-rmk2-pxa. All self-compiled with
self-ported platform-specific patches. Sure, none of those patches touches
any NFS / network general code. It might modify some (including network)
drivers, and, of course the core functionality (interrupt-handling,
memory, DMA, etc.) The first 2 also had real-time patches (RTAI), 2.6 on
PXA didn't. The pxa-patch for 2.6 was self-ported from 2.6.0-rmk1-test2,
IIRC. So, theoretically, you can blame any of those modifications, but I
highly doubt, that I managed to mess up all 3 kernels on 2 different
platforms to produce the same error, whereas all the rest (of course,
those, that I checked, i.e. ftp, http, telnet, tftp, tcp-nfs) network
protocols work.

Guennadi
---
Guennadi Liakhovetski


