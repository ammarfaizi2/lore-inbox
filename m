Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWCGAFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWCGAFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWCGAFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:05:39 -0500
Received: from mx.pathscale.com ([64.160.42.68]:48616 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751022AbWCGAFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:05:38 -0500
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for
	RDMA connection manager
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, netdev@vger.kernel.org
In-Reply-To: <adapskz3zw7.fsf@cisco.com>
References: <aday7zn432b.fsf@cisco.com>
	 <20060306.143901.26500391.davem@davemloft.net> <adau0ab42ni.fsf@cisco.com>
	 <20060306.145053.129802994.davem@davemloft.net> <adapskz3zw7.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Mon, 06 Mar 2006 16:05:30 -0800
Message-Id: <1141689930.3814.69.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 15:40 -0800, Roland Dreier wrote:

> Anyway IB works fine with standard INTx interrupts -- MSI is just icing.

Depends on the driver.  Ours needs the interrupt vector rather than the
number, which means we don't work without CONFIG_PCI_MSI.  That is,
unless there's some other way to get the vector that I don't know about
(entirely likely).

	<b

