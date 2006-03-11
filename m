Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWCKEUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWCKEUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 23:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWCKEUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 23:20:03 -0500
Received: from mx.pathscale.com ([64.160.42.68]:5791 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932427AbWCKEUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 23:20:01 -0500
Subject: Re: [openib-general] [PATCH 0 of 20] [RFC] ipath driver - another
	round for review
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Grant Grundler <iod00d@hp.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net
In-Reply-To: <20060310223041.GA15307@esmail.cup.hp.com>
References: <patchbomb.1141950930@eng-12.pathscale.com>
	 <20060310153559.GA12778@mellanox.co.il>
	 <1142006537.29925.13.camel@serpentine.pathscale.com>
	 <20060310174806.GA13969@esmail.cup.hp.com>
	 <1142013259.29925.69.camel@serpentine.pathscale.com>
	 <20060310223041.GA15307@esmail.cup.hp.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 20:20:21 -0800
Message-Id: <1142050821.31097.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 14:30 -0800, Grant Grundler wrote:

> > We already implement SDP.
> 
> ah ok.
> Is your SDP slower than the "ethernet emulation" for message passing?

I don't recall off the top of my head.

> You missed the netdev and netfilter guys ranting when Infiniband
> promoters proprosed putting a switch in the kernel to bypass
> the TCP/IP stack when SDP was available.

No, I saw that happen.  The ipath_ether driver doesn't bypass anything
in any way.

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

