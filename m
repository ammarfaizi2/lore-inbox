Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVLGVc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVLGVc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbVLGVc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:32:26 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5558
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751786AbVLGVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:32:25 -0500
Date: Wed, 07 Dec 2005 13:32:36 -0800 (PST)
Message-Id: <20051207.133236.97581111.davem@davemloft.net>
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
References: <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
	<20051207.123458.26771065.davem@davemloft.net>
	<Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Wed, 7 Dec 2005 22:22:42 +0100 (CET)

> I'm using the sunffb driver, as I wish to get the output from my creator3d 
> card, so that I can see something displayed as the monitor requiers a 13W3 
> connector. So I assume from your reply that framebuffer isn't working in 
> kernel 2.6 for sparc, but for other archs like ppc?

No, that should work just fine.  Just make sure "sunffb" is specified
as the driver to use in the xorg.conf file.

I have an ultra60 with creator here and I'll try to reproduce your
problem.

