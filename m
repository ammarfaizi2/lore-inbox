Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbTIDQWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTIDQVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:21:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35503 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265173AbTIDQTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:19:48 -0400
Date: Thu, 4 Sep 2003 09:09:51 -0700
From: "David S. Miller" <davem@redhat.com>
To: dsaxena@mvista.com
Cc: paulus@samba.org, rmk@arm.linux.org.uk, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904090951.7e678cb5.davem@redhat.com>
In-Reply-To: <20030904155004.GA31420@xanadu.az.mvista.com>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	<20030904023624.592f1601.davem@redhat.com>
	<20030904104801.A7387@flint.arm.linux.org.uk>
	<16215.14133.352143.660688@nanango.paulus.ozlabs.org>
	<20030904155004.GA31420@xanadu.az.mvista.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 08:50:04 -0700
Deepak Saxena <dsaxena@mvista.com> wrote:

> I think we need to a have a resource tree per _bus_, not just PCI.
> I have systems which have overlapping devices in multiple PCI domains
> and devices on the local memory bus that also overlap.

The physical address ranges are unique, I really don't see
any problem.
