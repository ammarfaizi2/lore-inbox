Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVKKUEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVKKUEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVKKUEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:04:41 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51602
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751124AbVKKUEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:04:41 -0500
Date: Fri, 11 Nov 2005 12:04:42 -0800 (PST)
Message-Id: <20051111.120442.94907827.davem@davemloft.net>
To: patrick@tykepenguin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DECnet fix SIGPIPE
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051111133547.GA28775@tykepenguin.com>
References: <20051111133547.GA28775@tykepenguin.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Caulfield <patrick@tykepenguin.com>
Date: Fri, 11 Nov 2005 13:35:47 +0000

> This patch fixes SIGIPIPE for DECnet. Currently recvmsg generates SIGPIPE
> whereas sendmsg does not; for the other stacks it seems to be the other way
> round!
> 
> It also fixes the bug where reading from a socket whose peer has shutdown
> returned -EINVAL rather than 0.
> 
> Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

Applied, thanks Patrick.
