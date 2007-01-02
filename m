Return-Path: <linux-kernel-owner+w=401wt.eu-S1755249AbXABDtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbXABDtt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 22:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755253AbXABDts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 22:49:48 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46748
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755249AbXABDtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 22:49:47 -0500
Date: Mon, 01 Jan 2007 19:49:46 -0800 (PST)
Message-Id: <20070101.194946.78711642.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: wmb@firmworks.com, devel@laptop.org, linux-kernel@vger.kernel.org,
       jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167709531.6165.9.camel@localhost.localdomain>
References: <459714A6.4000406@firmworks.com>
	<20061230.211941.74748799.davem@davemloft.net>
	<1167709531.6165.9.camel@localhost.localdomain>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Jan 2007 14:45:31 +1100

> In addition, I haven't given on the idea one day of actually merging the
> powerpc and sparc implementation of a lot of that stuff. Mostly the
> device-tree accessors proper, the of_device/of_platform bits etc... into
> something like drivers/of1394 maybe.
> 
> Thus if i386 is going to have a device-tree, please use the same
> interfaces.

Yes a large amount of the code is identical.

In fact we've been finding bugs in each other's stuff along
the way, so the sooner we consolidate the sooner we stop
having to fix every bug twice :)
