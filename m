Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264784AbTIDIJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 04:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264785AbTIDIJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 04:09:47 -0400
Received: from rth.ninka.net ([216.101.162.244]:201 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264784AbTIDIJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 04:09:46 -0400
Date: Thu, 4 Sep 2003 01:09:40 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: paulus@samba.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904010940.5fa0e560.davem@redhat.com>
In-Reply-To: <20030904073845.GA14669@lst.de>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<20030904073845.GA14669@lst.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 09:38:45 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Umm, right, so the typedef name is also completly bogus, if we're
> going to go that route it needs to be something likeb iocookie_t.

My suggestion is to just pass a resource and an offset to ioremap().
