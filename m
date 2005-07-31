Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVGaWlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVGaWlB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVGaWin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:38:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52956
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262017AbVGaWgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:36:35 -0400
Date: Sun, 31 Jul 2005 15:36:31 -0700 (PDT)
Message-Id: <20050731.153631.70217457.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove support for gcc < 3.2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050731222606.GL3608@stusta.de>
References: <20050731222606.GL3608@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 1 Aug 2005 00:26:07 +0200

> - my impression is that the older compilers are only rarely
>   used, so miscompilations of a driver with an old gcc might
>   not be detected for a longer amount of time

Many people still use 2.95 because it's still the fastest
way to get a kernel build done and that's important for
many people.

And with 4.0 being a scary regression in the compile time
performance area compared to 3.4, this becomes even more
important to keep around.
