Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265700AbUAJW54 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265710AbUAJW54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:57:56 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:30382 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265700AbUAJW5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:57:42 -0500
Date: Sat, 10 Jan 2004 14:57:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040110225736.GD17845@matchmail.com>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040110223412.GC17845@matchmail.com> <Pine.LNX.4.44.0401102343070.7120-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401102343070.7120-100000@poirot.grange>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 11:52:16PM +0100, Guennadi Liakhovetski wrote:
> On Sat, 10 Jan 2004, Mike Fedyk wrote:
> 
> > What version is the arm kernel you're running on the client, and where is it
> > from?
> 
> 2.4.19-rmk7, 24.4.21-rmk1-pxa1, 2.6.0-rmk2-pxa. All self-compiled with
> self-ported platform-specific patches. Sure, none of those patches touches
> any NFS / network general code. It might modify some (including network)
> drivers, and, of course the core functionality (interrupt-handling,
> memory, DMA, etc.) The first 2 also had real-time patches (RTAI), 2.6 on
> PXA didn't. The pxa-patch for 2.6 was self-ported from 2.6.0-rmk1-test2,
> IIRC. So, theoretically, you can blame any of those modifications, but I
> highly doubt, that I managed to mess up all 3 kernels on 2 different
> platforms to produce the same error, whereas all the rest (of course,
> those, that I checked, i.e. ftp, http, telnet, tftp, tcp-nfs) network
> protocols work.

Can you double check with a vanilla kernel.org 2.4.24 x86 client?
