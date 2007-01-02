Return-Path: <linux-kernel-owner+w=401wt.eu-S1755252AbXABDpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbXABDpm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 22:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbXABDpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 22:45:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:51163 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbXABDpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 22:45:41 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: wmb@firmworks.com, devel@laptop.org, linux-kernel@vger.kernel.org,
       jg@laptop.org
In-Reply-To: <20061230.211941.74748799.davem@davemloft.net>
References: <459714A6.4000406@firmworks.com>
	 <20061230.211941.74748799.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 14:45:31 +1100
Message-Id: <1167709531.6165.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I would strongly suggest looking at things like
> arch/{sparc,sparc64,powerpc}/kernel/prom.c and
> include/asm-{sparc,sparc64,powerpc}/prom.h and
> arch/{sparc,sparc64,powerpc}/kernel/of_device.c and
> include/asm-{sparc,sparc64,powerpc}/of_device.h
> since we've already invested a lot of thought and
> infrastructure into providing interfaces to this information
> on powerpc and the two sparc platforms.

In addition, I haven't given on the idea one day of actually merging the
powerpc and sparc implementation of a lot of that stuff. Mostly the
device-tree accessors proper, the of_device/of_platform bits etc... into
something like drivers/of1394 maybe.

Thus if i386 is going to have a device-tree, please use the same
interfaces.

Ben.


