Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbWASBOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWASBOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWASBOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:14:22 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50314 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161133AbWASBOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:14:22 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       greg@kroah.com, openib-general@openib.org
In-Reply-To: <20060118.164839.74431051.davem@davemloft.net>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <20060118.164839.74431051.davem@davemloft.net>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 18 Jan 2006 17:14:16 -0800
Message-Id: <1137633256.4757.225.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 16:48 -0800, David S. Miller wrote:

> You can use an interface such a netlink for device configuration.
> It can do better type checking, can be used by generic tools, and
> some day soon will be transferable over the wire so that one can
> perform remote configuration changes.

That looks doable, but to my eyes, the netlink interface looks both more
cumbersome and less reliable than ioctl.  At least it apparently lets us
do arbitrarily peculiar things :-)

	<b

