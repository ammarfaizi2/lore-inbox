Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWCJRsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWCJRsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWCJRsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:48:00 -0500
Received: from palrel10.hp.com ([156.153.255.245]:47247 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751146AbWCJRr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:47:59 -0500
Date: Fri, 10 Mar 2006 09:48:06 -0800
From: Grant Grundler <iod00d@hp.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net
Subject: Re: [openib-general] [PATCH 0 of 20] [RFC] ipath driver - another round for review
Message-ID: <20060310174806.GA13969@esmail.cup.hp.com>
References: <patchbomb.1141950930@eng-12.pathscale.com> <20060310153559.GA12778@mellanox.co.il> <1142006537.29925.13.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142006537.29925.13.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 08:02:16AM -0800, Bryan O'Sullivan wrote:
> > Two questions on this
> > 1. It is not standard ethernet nor standard IP over Infiniband either, is it?
> 
> Correct.
> 
> > Is there some documentation on the wire protocol that you use?
> 
> No, but the encapsulation is very simple and easy to figure out from
> reading the code.
> 
...
> > 2. Are there practical reasons why you get lower latency and higher
> > bandwidth with this than with IPoIB?
> 
> The principal reason is that we haven't had time to pay attention to
> IPoIB performance yet.  The ipath_ether driver was developed before
> IPoIB was usable for any real work.

My gut feeling is you want to look at SDP first.
I'm skeptical that yet another wire protocol will get
accepted into the linux kernel.

grant
