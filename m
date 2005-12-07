Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVLGUeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVLGUeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 15:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbVLGUeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 15:34:50 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2184
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751752AbVLGUet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 15:34:49 -0500
Date: Wed, 07 Dec 2005 12:34:58 -0800 (PST)
Message-Id: <20051207.123458.26771065.davem@davemloft.net>
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
References: <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
	<20051206.152316.82233251.davem@davemloft.net>
	<Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Wed, 7 Dec 2005 12:05:43 +0100 (CET)

> When running in plain console (without trying to run X) everything works 
> fine (just telling that so I won't get people to ask if ps segfaults in 
> other cases or claims that my init is broke and so on).

Is the Xorg.conf setup to use the "ati" driver?  You can't use
"fbdev" or similar, that will in fact hang the machine in a
manner similar to how you describe.
