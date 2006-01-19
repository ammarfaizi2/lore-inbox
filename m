Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWASBRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWASBRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWASBRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:17:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46270
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161140AbWASBRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:17:16 -0500
Date: Wed, 18 Jan 2006 17:17:16 -0800 (PST)
Message-Id: <20060118.171716.04998471.davem@davemloft.net>
To: bos@pathscale.com
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       greg@kroah.com, openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1137633256.4757.225.camel@serpentine.pathscale.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	<20060118.164839.74431051.davem@davemloft.net>
	<1137633256.4757.225.camel@serpentine.pathscale.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Sullivan <bos@pathscale.com>
Date: Wed, 18 Jan 2006 17:14:16 -0800

> That looks doable, but to my eyes, the netlink interface looks both
> more cumbersome and less reliable than ioctl.  At least it
> apparently lets us do arbitrarily peculiar things :-)

It's going to give you strict typing, and extensible attributes for
the configuration attributes you define.  So if you determine later
"oh we need to add this knob for changing X" you can do that without
breaking the existing interface.  With ioctl() that is usually
impossible or unreasonably hard to accomplish.

Try not to get discouraged, give it a shot :)
