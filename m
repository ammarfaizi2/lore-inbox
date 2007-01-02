Return-Path: <linux-kernel-owner+w=401wt.eu-S1753683AbXABUYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbXABUYE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbXABUYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:24:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57635 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbXABUYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:24:03 -0500
Date: Tue, 2 Jan 2007 12:22:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org, hch@lst.de,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
Subject: Re: [PATCH] slab: cache alloc cleanups
Message-Id: <20070102122221.9cbca597.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007 15:47:06 +0200 (EET)
Pekka J Enberg <penberg@cs.helsinki.fi> wrote:

> I have been unable to find a NUMA-capable tester for this patch, 

Any x86_64 box can be used to test NUMA code via the numa=fake=N boot option.

fake-numa is somewhat sick in mainline and you might find that it doesn't
work right on some machines, or that it fails with high values of N, but
works OK with N=2.  There are fixes to address this problem in -mm.
