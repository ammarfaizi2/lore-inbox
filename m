Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVBRVfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVBRVfD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVBRVeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:34:37 -0500
Received: from bender.bawue.de ([193.7.176.20]:53730 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261528AbVBRVdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:33:39 -0500
Date: Fri, 18 Feb 2005 22:33:32 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Question on CONFIG_IRQBALANCE / 2.6.x
Message-ID: <20050218213332.GA13485@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

there's something I don't understand:  With IRQBALANCE *enabled* almost
all interrupts are processed on CPU0.  This changed in an unexpected way
after disabling IRQBALANCE: now all interrupts are distributed uniformly
to both CPUs.  Maybe it's intentional, but it's not what I expect when a
config option named IRQBALANCE is *disabled*.

Can anybody comment on this?

Thanks,
-jo

-- 
-rw-r--r--  1 jo users 63 2005-02-18 21:21 /home/jo/.signature
