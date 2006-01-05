Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWAEPbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWAEPbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWAEPbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:31:20 -0500
Received: from mx.pathscale.com ([64.160.42.68]:37834 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932074AbWAEPbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:31:19 -0500
Subject: Re: [openib-general] Re: [PATCH 0 of 20] [RFC] ipath - PathScale
	InfiniPath driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <adasls34r9e.fsf@cisco.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <20051230080002.GA7438@kroah.com>
	 <1135984304.13318.50.camel@serpentine.pathscale.com>
	 <20051231001051.GB20314@kroah.com>
	 <1135993250.13318.94.camel@serpentine.pathscale.com>
	 <20060103172732.GA9170@kroah.com>
	 <1136321691.10862.61.camel@localhost.localdomain>
	 <adasls34r9e.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 05 Jan 2006 07:31:18 -0800
Message-Id: <1136475079.31922.18.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 13:28 -0800, Roland Dreier wrote:

> Isn't there some way you can use the same SMA (subnet management
> agent) interface in all the cases?

I'll look into it, but I rather doubt it.

> Can ipath_mad.c just go away in
> favor of your userspace SMA?

Our userspace SMA is a tiny shrivelled thing that expects there to be a
real subnet manager out there, so it only needs a very simple interface,
and it's decoupled from OpenIB entirely.  ipath_mad.c is part of our
OpenIB layer, so it can't really go away.

	<b

