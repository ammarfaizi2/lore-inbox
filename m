Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266420AbUFQIyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266420AbUFQIyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266424AbUFQIyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:54:14 -0400
Received: from aun.it.uu.se ([130.238.12.36]:396 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266420AbUFQIyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:54:13 -0400
Date: Thu, 17 Jun 2004 10:54:00 +0200 (MEST)
Message-Id: <200406170854.i5H8s0v5012548@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       peter@cordes.ca
Subject: Re: x86-64: double timer interrupts in recent 2.4.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 16:28:26 -0300, Peter Cordes wrote:
> I just noticed that on my Opteron cluster, the nodes that are running 64bit
>kernels have their clocks ticking at double speed.  This happens with
>Linux 2.4.26, and 2.4.27-pre2

I had the same problem: 2.4 x86-64 kernels ticking the clock
twice its normal speed, unless I booted with pci=noacpi.

This got fixed very recently I believe, in a 2.4.27-pre kernel.

/Mikael
