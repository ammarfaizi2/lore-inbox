Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWACUzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWACUzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWACUzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:55:10 -0500
Received: from mx.pathscale.com ([64.160.42.68]:59330 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932478AbWACUzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:55:09 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060103172732.GA9170@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <20051230080002.GA7438@kroah.com>
	 <1135984304.13318.50.camel@serpentine.pathscale.com>
	 <20051231001051.GB20314@kroah.com>
	 <1135993250.13318.94.camel@serpentine.pathscale.com>
	 <20060103172732.GA9170@kroah.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 12:54:50 -0800
Message-Id: <1136321691.10862.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 09:27 -0800, Greg KH wrote:

> Idealy, nothing should be new ioctls.  But in the end, it all depends on
> exactly what you are trying to do with each different one.

Fair enough.

> I really don't know what the subnet management stuff involves, sorry.
> But doesn't the open-ib layer handle that all for you already?

It does when our OpenIB driver is being used.  But our lower level
driver is independent of OpenIB (and is often used without the
infiniband stuff even configured into the kernel), and needs to provide
some way for a userspace subnet management agent to send and receive
packets.

	<b

