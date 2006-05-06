Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWEFBoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWEFBoO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 21:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWEFBoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 21:44:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31396
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750793AbWEFBoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 21:44:13 -0400
Date: Fri, 05 May 2006 18:41:58 -0700 (PDT)
Message-Id: <20060505.184158.131584956.davem@davemloft.net>
To: shemminger@osdl.org
Cc: greg@kroah.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netdev: create attribute_groups with
 class_device_add
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060421125438.50f93a34@localhost.localdomain>
References: <20060421125255.3451959f@localhost.localdomain>
	<20060421125438.50f93a34@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 21 Apr 2006 12:54:38 -0700

> Atomically create attributes when class device is added. This avoids the
> race between registering class_device (which generates hotplug event),
> and the creation of attribute groups.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Did the first patch that adds the attribute_group creation
infrastructure go in so that we can get this networking fix in?
