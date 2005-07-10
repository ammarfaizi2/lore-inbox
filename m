Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVGJVx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVGJVx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGJVvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 17:51:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32972
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261969AbVGJVuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 17:50:07 -0400
Date: Sun, 10 Jul 2005 14:49:10 -0700 (PDT)
Message-Id: <20050710.144910.15269860.davem@davemloft.net>
To: olh@suse.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much,
 for no good reason.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>
References: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An 82 entry patchbomb to the mailing lists is unacceptable and is
going to kill vger.kernel.org, please don't do this.

If you cannot condense your patch set into a smaller set of patches (I
think you really could for this one), then only post say 10 or so at a
time and wait for review and integration.

Kernel janitor-like patches split up their work _FAR_ too much.  They
post one patch per driver, or even per-file, for something as simple
as removing the use of a redundant header file.  That's totally
rediculious, and bloats up the kernel changelog history for no good
reason.  Instead, you should just post one big patch for all of
drivers/, one for all of net/, something like that.

Thanks.
