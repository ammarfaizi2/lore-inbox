Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWJUGit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWJUGit (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 02:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWJUGit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 02:38:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13805
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751752AbWJUGis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 02:38:48 -0400
Date: Fri, 20 Oct 2006 23:38:50 -0700 (PDT)
Message-Id: <20061020.233850.02297930.davem@davemloft.net>
To: davej@redhat.com
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061021050016.GD21948@redhat.com>
References: <20061020.125226.59656580.davem@davemloft.net>
	<20061020132532.65a3e655@dxpl.pdx.osdl.net>
	<20061021050016.GD21948@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Sat, 21 Oct 2006 01:00:16 -0400

> Practically no-one cared about it, so it bit-rotted really fast
> after we shipped RHEL4.  That, along with the focus shifting to
> making kdump work seemed to kill it off over the last 12 months.

Then we can truly kill off the ->drop() callback as part
of Stephen's patches.

Stephen, I'll review your new set over the weekend.
