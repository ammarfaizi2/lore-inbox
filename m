Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbTK2XRL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 18:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbTK2XRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 18:17:11 -0500
Received: from dp.samba.org ([66.70.73.150]:21152 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264577AbTK2XRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 18:17:09 -0500
Date: Sun, 30 Nov 2003 09:35:52 +1100
From: Anton Blanchard <anton@samba.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [PATCH][2.6] e100_phy.c uses free'd .text after init
Message-ID: <20031129223552.GA24362@krispykreme>
References: <Pine.LNX.4.58.0311290033120.1674@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311290033120.1674@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zwane,

> This was causing an oops when using mii-tool due to the .text being free'd
> after initialisation.

We stumbled across this a few weeks ago, Jeff's BK tree should have a
fix.

Anton
