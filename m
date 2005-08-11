Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVHKAF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVHKAF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVHKAF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:05:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62677
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964885AbVHKAF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:05:59 -0400
Date: Wed, 10 Aug 2005 17:05:57 -0700 (PDT)
Message-Id: <20050810.170557.26275541.davem@davemloft.net>
To: joecool1029@gmail.com
Cc: davidsen@tmr.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: remove support for gcc < 3.2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <d4757e6005081017024c3bf3fd@mail.gmail.com>
References: <20050731.153631.70217457.davem@davemloft.net>
	<42FA5848.809@tmr.com>
	<d4757e6005081017024c3bf3fd@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe <joecool1029@gmail.com>
Date: Wed, 10 Aug 2005 20:02:33 -0400

> With all the changes and deprications it seems pointless to have to
> maintain extra code so 3 people can use an obsolete compiler.

This number is enormously greater than 3, and especially it's
important because the folks who are quite important to kernel
development (read as: Andrew Morton) rely on the build efficiency of
gcc-2.95 so that they can actually get their daily work done.

Some of us spend the majority of our time doing patch applying and
verification kernel builds, and often not much more than that.

Therefore kernel build time is enormously important, and gcc-2.95
is the best option as far as that goes.
