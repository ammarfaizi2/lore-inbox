Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWEIXsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWEIXsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWEIXsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:48:52 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16003 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932277AbWEIXsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:48:51 -0400
Date: Tue, 9 May 2006 16:51:22 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, Christian.Limpach@cl.cam.ac.uk,
       xen-devel@lists.xensource.com, netdev@vger.kernel.org,
       ian.pratt@xensource.com
Subject: Re: [Xen-devel] [RFC PATCH 34/35] Add the Xen virtual network device	driver.
Message-ID: <20060509235122.GJ24291@moss.sous-sol.org>
References: <20060509085201.446830000@sous-sol.org> <E1FdatV-0000lj-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FdatV-0000lj-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Xu (herbert@gondor.apana.org.au) wrote:
> Chris Wright <chrisw@sous-sol.org> wrote:
> >
> > +       netdev->features        = NETIF_F_IP_CSUM;
> 
> Any reason why IP_CSUM was chosen instead of HW_CSUM? Doing the latter
> would seem to be in fact easier for a virtual driver, no?

That, I really don't know.

thanks,
-chris
