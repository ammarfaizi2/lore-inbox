Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWCIXVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWCIXVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWCIXVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:21:53 -0500
Received: from mx.pathscale.com ([64.160.42.68]:21893 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932118AbWCIXVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:21:52 -0500
Subject: Re: [PATCH 4 of 20] ipath - support for HyperTransport devices
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <ada3bhrgr36.fsf@cisco.com>
References: <0b1b4f4c093e2db6153e.1141922817@localhost.localdomain>
	 <ada3bhrgr36.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:21:41 -0800
Message-Id: <1141946501.10693.32.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:01 -0800, Roland Dreier wrote:

> It seems like all these hypertransport magic constants should be in a
> general .h somewhere.  I'm not sure if it makes sense to put them in
> <linux/pci.h>, or start a <linux/hypertransport.h>.

Either way is fine by me.

> The logic here is pretty hard to follow, and you're getting squeezed
> pretty hard by indenting 5 tabs stops.  Can ipath_setup_ht_config() be
> split up into subfunctions?

Definitely.  I mentioned this in the introductory message for the series
as something I'm working on.

	<b

