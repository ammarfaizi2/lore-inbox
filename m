Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVFWFG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVFWFG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVFWFGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:06:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53424
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262367AbVFWFGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:06:49 -0400
Date: Wed, 22 Jun 2005 22:06:33 -0700 (PDT)
Message-Id: <20050622.220633.34603084.davem@davemloft.net>
To: jmoyer@redhat.com
Cc: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 0/3] netpoll: support multiple netpoll clients per
 net_device
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17082.4037.875432.648439@segfault.boston.redhat.com>
References: <17082.4037.875432.648439@segfault.boston.redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 22 Jun 2005 21:26:29 -0400

> This patch series restores the ability to register multiple netpoll clients
> against the same network interface.  To this end, I created a new structure:
 ...
> I have tested this by registering two netpoll clients, and verifying that
> they both function properly.  The clients were netconsole, and a quick
> module I hacked together to send console messages to syslog.  I issued
> sysrq-h, sysrq-m, and sysrq-t's both by echo'ing to /proc/sysrq-trigger and
> by hitting the key combination on the keyboard.  This verifies that the
> modules work both inside and out of interrupt context.

This all looks great.  I've applied all 3 patches.

Thanks for taking care of this Jeff.
