Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWBSBRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWBSBRB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 20:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWBSBRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 20:17:01 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20891
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964797AbWBSBRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 20:17:00 -0500
Date: Sat, 18 Feb 2006 17:17:04 -0800 (PST)
Message-Id: <20060218.171704.89115583.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: don't bother users with unimportant messages.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060219010910.GA18841@redhat.com>
References: <20060219010910.GA18841@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Sat, 18 Feb 2006 20:09:10 -0500

> When users see these printed to the console, they think
> something is wrong.  As it's just informational and something
> that only developers care about, lower the printk level.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

I'm partly against such changes, especially lately...

I've been burned so many times over the past few days by things like
installers, klogd, and whatever else changing the loglevel on me so
that the one console message I needed to see right before the machine
hung doesn't get printed out.
