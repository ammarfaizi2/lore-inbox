Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUF1IOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUF1IOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 04:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUF1IOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 04:14:23 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:18156 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264895AbUF1IOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 04:14:19 -0400
Date: Mon, 28 Jun 2004 01:14:10 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040628081410.GA5321@taniwha.stupidest.org>
References: <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com> <20040625124807.GA29937@infradead.org> <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com> <20040626235248.GC12761@taniwha.stupidest.org> <Pine.SGI.4.53.0406271908390.524706@subway.americas.sgi.com> <20040628003311.GA23017@taniwha.stupidest.org> <20040628021439.A17654@flint.arm.linux.org.uk> <20040628014443.GA24247@taniwha.stupidest.org> <20040628085429.C32206@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628085429.C32206@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 08:54:30AM +0100, Russell King wrote:

> If you're going to do that, why not just disable 8250 in the kernels
> configuration?

Generic ia64 kernels need to work on hardware with 8250-like UARTS.
These kernel will also work and boot on SN2 which will never (heh)
have this hardware so a run-time check is required.

> It has exactly the same effect.  With the change you propose, you
> can't even use 8250 for PCMCIA serial cards.

Altix has no PCMCIA.


  --cw
