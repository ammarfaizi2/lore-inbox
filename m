Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbTIDOj6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265085AbTIDOj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:39:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36782 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265087AbTIDOju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:39:50 -0400
Date: Thu, 4 Sep 2003 07:30:09 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: paulus@samba.org, rmk@arm.linux.org.uk, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904073009.6684112e.davem@redhat.com>
In-Reply-To: <20030904073650.B22822@home.com>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	<20030904023624.592f1601.davem@redhat.com>
	<20030904073650.B22822@home.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 07:36:50 -0700
Matt Porter <mporter@kernel.crashing.org> wrote:

> Ok, now the other part of making PCI devices work is to support
> mmap.

You get the pci device in the arch PCI mmap() routines, what
more do you need?  Grep for HAVE_PCI_MMAP in the source tree
and how sparc64 implements that.
