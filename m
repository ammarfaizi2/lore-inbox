Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbVLAUOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbVLAUOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVLAUOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:14:20 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4482
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751721AbVLAUOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:14:19 -0500
Date: Thu, 01 Dec 2005 12:14:21 -0800 (PST)
Message-Id: <20051201.121421.58532275.davem@davemloft.net>
To: lkml@rtr.ca
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Fix bytecount result from printk()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <438F1D05.5020004@rtr.ca>
References: <438F1D05.5020004@rtr.ca>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Lord <lkml@rtr.ca>
Date: Thu, 01 Dec 2005 10:55:49 -0500

> Whether or not the count should even exist in the first place
> is still a question for examination -- nothing appears to use it.

I think it should be killed, in all of my Linux kernel
hacking I've never seen a user of this return value. :-)
