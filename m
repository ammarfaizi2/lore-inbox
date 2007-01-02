Return-Path: <linux-kernel-owner+w=401wt.eu-S1755256AbXABD4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbXABD4V (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 22:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXABD4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 22:56:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:46105 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256AbXABD4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 22:56:21 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Kahn <dmk@flex.com>
Cc: David Miller <davem@davemloft.net>, wmb@firmworks.com, devel@laptop.org,
       linux-kernel@vger.kernel.org, jg@laptop.org
In-Reply-To: <4597A4A2.9060304@flex.com>
References: <20061230.211941.74748799.davem@davemloft.net>
	 <459784AD.1010308@firmworks.com>	<45978CE9.7090700@flex.com>
	 <20061231.024917.59652177.davem@davemloft.net>  <4597A4A2.9060304@flex.com>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 14:56:07 +1100
Message-Id: <1167710167.6165.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is a trivial implementation that suits it's purpose.
> It's simple. I'm not sure what more is needed for this
> project when it's pretty clear that i386 will never need
> any additional support for open firmware.

I don't agree. It's definitely not clear to me.... Especially as open
source OF implementations are starting to show up, it makes a lot of
sense to start representing non-enumerable devices (CPUs, legacy
devices, embedded things etc...) in the device-tree and I fail to see
why an x86 OF-based machine would not get the ability to use it in the
same way as powerpc or sparc does in that regard.

Ben.


