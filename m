Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWGDB5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWGDB5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 21:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWGDB5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 21:57:32 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46796
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751358AbWGDB5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 21:57:31 -0400
Date: Mon, 03 Jul 2006 18:57:47 -0700 (PDT)
Message-Id: <20060703.185747.74753207.davem@davemloft.net>
To: greg@kroah.com
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [RFC] change netdevice to use struct device instead of struct
 class_device
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060703231610.GA18352@kroah.com>
References: <20060703224719.GA14176@kroah.com>
	<44A9A345.8040706@garzik.org>
	<20060703231610.GA18352@kroah.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Mon, 3 Jul 2006 16:16:10 -0700

> No, not really.  According to Documentation/ABI/testing/sysfs-class all
> code that uses /sys/class/foo/ needs to be able to handle the fact that
> those entries might be symlinks and not just directories.  Everything
> that I know of already works properly because the input layer has had
> symlinks in /sys/class/input for quite some time now.
> 
> Do you know of any tools that use /sys/class/net/ that can not handle
> symlinks there?  I've been running this on my boxes for about a week now
> with no noticeable issues.  Renaming interfaces works just fine too.

I do not think this change will cause any problems.
