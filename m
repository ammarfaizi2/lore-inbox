Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947129AbWKKHXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947129AbWKKHXk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 02:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947131AbWKKHXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 02:23:40 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53889
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1947129AbWKKHXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 02:23:39 -0500
Date: Fri, 10 Nov 2006 23:23:42 -0800 (PST)
Message-Id: <20061110.232342.35009769.davem@davemloft.net>
To: shemminger@osdl.org
Cc: a1426z@gawab.com, arjan@infradead.org, rdunlap@xenotime.net,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061110210917.2bd568ab@localhost.localdomain>
References: <20061110133101.4e6cddd3@freekitty>
	<200611110715.49343.a1426z@gawab.com>
	<20061110210917.2bd568ab@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 10 Nov 2006 21:09:17 -0800

> On Sat, 11 Nov 2006 07:15:49 +0300
> Al Boldi <a1426z@gawab.com> wrote:
> 
> > Stephen Hemminger wrote:
> > > Al Boldi <a1426z@gawab.com> wrote:
> > I meant structural OSI compliance.
> 
> Read the book "Network Algorithmics"; it has a clear discussion
> of why building your stack like the protocol specification
> is a bad idea.

Even Van Jacobson can be quoted as saying (to the effect) that
layering is how you design protocols, _NOT_ how you implement
them.
