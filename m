Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWISWG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWISWG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWISWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:06:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36776
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751188AbWISWGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:06:24 -0400
Date: Tue, 19 Sep 2006 15:06:29 -0700 (PDT)
Message-Id: <20060919.150629.109607267.davem@davemloft.net>
To: rjw@sisk.pl
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       greg@kroah.com
Subject: Re: 2.6.18-rc7-mm1: networking breakage on HPC nx6325 + SUSE 10.1
From: David Miller <davem@davemloft.net>
In-Reply-To: <200609200006.53138.rjw@sisk.pl>
References: <20060919133606.f0c92e66.akpm@osdl.org>
	<200609192330.34769.rjw@sisk.pl>
	<200609200006.53138.rjw@sisk.pl>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 20 Sep 2006 00:06:52 +0200

> I _guess_ the problem is caused by
> gregkh-driver-network-class_device-to-device.patch, but I can't verify this,
> because the kernel (obviously) doesn't compile if I revert it.

Indeed.

I thought we threw this patch out because we knew it would cause
problems for existing systems?  I do remember Greg making an argument
as to why we needed the change, but that doesn't make breaking people's
systems legitimate in any way.

