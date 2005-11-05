Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVKEX7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVKEX7l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVKEX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 18:59:41 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31946
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932224AbVKEX7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 18:59:41 -0500
Date: Sat, 05 Nov 2005 15:58:03 -0800 (PST)
Message-Id: <20051105.155803.06251914.davem@davemloft.net>
To: sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc{,64}: remove duplicate TIOCPKT_ definitions
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051103133907.1fb5008b.sfr@canb.auug.org.au>
References: <20051103133907.1fb5008b.sfr@canb.auug.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 3 Nov 2005 13:39:07 +1100

> The TIOCPKT_ macros are defined by all other architectures in asm/ioctls.h
> and so does sparc and sparc64, so reomve the duplicates in asm/termios.h.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied, thanks Stephen.
