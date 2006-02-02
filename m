Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423395AbWBBJE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423395AbWBBJE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423396AbWBBJE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:04:27 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27598
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423395AbWBBJE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:04:26 -0500
Date: Thu, 02 Feb 2006 01:04:22 -0800 (PST)
Message-Id: <20060202.010422.72716040.davem@davemloft.net>
To: waters@inbox.lv
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEVICE POLLING
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <293455779.20060202104554@inbox.lv>
References: <293455779.20060202104554@inbox.lv>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: kasp <waters@inbox.lv>
Date: Thu, 2 Feb 2006 10:45:54 +0200

> So, are there any feature like that in linux kernel supported?

Yes, it's called NAPI and it's on by default in many drivers.

But this is ancient history and a better scheme for dealing these
issues is coming soon, in the form of Van Jacobson's net channels.
