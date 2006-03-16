Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWCPX4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWCPX4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWCPX4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:56:08 -0500
Received: from mx.pathscale.com ([64.160.42.68]:22506 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964909AbWCPX4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:56:06 -0500
Subject: Re: Remapping pages mapped to userspace (was: [PATCH 10 of 20]
	ipath - support for userspace apps using core driver)
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <adad5gmne20.fsf_-_@cisco.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
	 <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	 <adad5gmne20.fsf_-_@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 16 Mar 2006 15:56:01 -0800
Message-Id: <1142553361.15045.19.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 15:51 -0800, Roland Dreier wrote:

> However, on a hot unplug event, when the underlying PCI device is
> going away, I would like to replace that mapping with a mapping (with
> a mapping to the zero page?), so that userspace accesses after the
> device is gone don't explode.

Why would you not want accesses to explode?  Exploding seems like the
right behaviour to me, since there's no hardware for userspace to talk
to any more.

	<b

