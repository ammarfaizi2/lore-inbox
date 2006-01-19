Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWASAsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWASAsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWASAsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:48:39 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44687
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161117AbWASAsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:48:38 -0500
Date: Wed, 18 Jan 2006 16:48:39 -0800 (PST)
Message-Id: <20060118.164839.74431051.davem@davemloft.net>
To: bos@pathscale.com
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       greg@kroah.com, openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1137631411.4757.218.camel@serpentine.pathscale.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Sullivan <bos@pathscale.com>
Date: Wed, 18 Jan 2006 16:43:31 -0800

> Obviously, we'd prefer the number to be zero, but I don't think we
> can do that without submitting a driver that isn't very useful.

You can use an interface such a netlink for device configuration.
It can do better type checking, can be used by generic tools, and
some day soon will be transferable over the wire so that one can
perform remote configuration changes.

Let's let ioctl()'s go the way of the cave man.  It's one of the
worst designed interfaces undef UNIX :)

