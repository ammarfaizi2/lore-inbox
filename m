Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbWIVWWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbWIVWWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbWIVWWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:22:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20390
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965204AbWIVWWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:22:42 -0400
Date: Fri, 22 Sep 2006 15:22:59 -0700 (PDT)
Message-Id: <20060922.152259.54193010.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, simoneau@ele.uri.edu,
       sparclinux@vger.kernel.org
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
From: David Miller <davem@davemloft.net>
In-Reply-To: <200609222215.k8MMFfAj023040@harpo.it.uu.se>
References: <200609222215.k8MMFfAj023040@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sat, 23 Sep 2006 00:15:41 +0200 (MEST)

> I rechecked with 2.6.18 final, and the behaviour is as I described:
> gcc-4.1.1 causes the alignment exceptions, while gcc-3.4.6 does not.
> I didn't get any PCI errors now, but I'm sure I did get them in the
> 2.6.17 or early 2.6.18-rc kernels.
> 
> Here's a dmesg diff to show what happens, between the gcc-4.1.1
> and gcc-3.4.6 compiled kernels. The first part is from kernel
> bootup + user-space modprobe of the USB EHCI etc modules:

Thanks for taking a look into this, I'll dig deeper when
I get a chance.
