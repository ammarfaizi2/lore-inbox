Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVFBUS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVFBUS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVFBUSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:18:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54488
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261324AbVFBUOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:14:39 -0400
Date: Thu, 02 Jun 2005 13:14:28 -0700 (PDT)
Message-Id: <20050602.131428.28787855.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/socket.c: unexport move_addr_to_kernel
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050530205647.GW10441@stusta.de>
References: <20050530205647.GW10441@stusta.de>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 30 May 2005 22:56:47 +0200

> I didn't find any modular usage in the kernel.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Yes, but as a part of the socket kernel API, I could
definitely see some out-of-tree code legitimately
using this interface.  Let's keep it around for now.
