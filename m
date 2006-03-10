Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWCJAsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWCJAsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWCJAst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:48:49 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50319 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422659AbWCJAsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:48:46 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <gregkh@suse.de>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060310004505.GB17050@suse.de>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <ada8xrjfbd8.fsf@cisco.com>
	 <1141948367.10693.53.camel@serpentine.pathscale.com>
	 <20060310004505.GB17050@suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 16:48:45 -0800
Message-Id: <1141951725.10693.88.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 16:45 -0800, Greg KH wrote:

> > We don't support hotplugged devices at the moment.
> 
> Why not?  Your cards can't be placed in a machine that supports PCI
> Hotplug (or PCI-E hotplug)?

No, the driver and userspace code doesn't support it yet.  That's all.

> You can't really tell users that (no matter
> how often I have wished I could...)

I don't expect this to be a practical problem.  We're planning to add
hotplug support to the driver once we have some cycles free.

	<b

