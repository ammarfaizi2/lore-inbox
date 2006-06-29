Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933011AbWF2WBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbWF2WBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932989AbWF2WBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:01:45 -0400
Received: from mx.pathscale.com ([64.160.42.68]:12178 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932975AbWF2WBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:01:40 -0400
Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath
	on PowerPC 970 systems
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060629.145319.71091846.davem@davemloft.net>
References: <patchbomb.1151617251@eng-12.pathscale.com>
	 <c22b6c244d5db77f7b1d.1151617289@eng-12.pathscale.com>
	 <20060629.145319.71091846.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 15:01:39 -0700
Message-Id: <1151618499.10886.26.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 14:53 -0700, David Miller wrote:
> From: Bryan O'Sullivan <bos@pathscale.com>
> Date: Thu, 29 Jun 2006 14:41:29 -0700
> 
> >  ipath_core-$(CONFIG_X86_64) += ipath_wc_x86_64.o
> > +ipath_core-$(CONFIG_PPC64) += ipath_wc_ppc64.o
> 
> Again, don't put these kinds of cpu specific functions
> into the infiniband driver.  They are potentially globally
> useful, not something only Infiniband might want to do.

The support for write combining in the kernel is not in a state where
that makes any sense at the moment.  Also, this is a single-statement
function.

	<b

