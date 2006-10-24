Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422712AbWJXWSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWJXWSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbWJXWSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:18:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11729
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161252AbWJXWSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:18:47 -0400
Date: Tue, 24 Oct 2006 15:18:51 -0700 (PDT)
Message-Id: <20061024.151851.32347810.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix RARP ic_servaddr breakage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061024211027.GG29920@ftp.linux.org.uk>
References: <20061024211027.GG29920@ftp.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 24 Oct 2006 22:10:27 +0100

> memcpy 4 bytes to address of auto unsigned long variable followed
> by comparison with u32 is a bloody bad idea.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied, good spotting Al.
