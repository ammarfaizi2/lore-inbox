Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136758AbREIRNX>; Wed, 9 May 2001 13:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136763AbREIRNN>; Wed, 9 May 2001 13:13:13 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:10323 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136761AbREIRNF>; Wed, 9 May 2001 13:13:05 -0400
Date: Wed, 9 May 2001 13:12:55 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200105091712.f49HCt005184@devserv.devel.redhat.com>
To: reality@delusion.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Problem with reenabling hub
In-Reply-To: <mailman.989413441.16162.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.989413441.16162.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> switching it back on, a problem occurs with reenabling the ports on
> that USB hub. The kernel output follows.

> Comments anyone?

Next time, post your /proc/version.

There were similar things recently (missing urb->dev
reinitialization in usb_hub_reset).

-- Pete
