Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWBJER7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWBJER7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWBJER7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:17:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751063AbWBJER6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:17:58 -0500
Date: Thu, 9 Feb 2006 20:17:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve Briggs <s-briggs@cecer.army.mil>
Cc: linux-ns83820@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/ns83820.c: add paramter to disable auto
 negotiation
Message-Id: <20060209201716.0c6d1fea.akpm@osdl.org>
In-Reply-To: <200602092203.28290.s-briggs@cecer.army.mil>
References: <200602092203.28290.s-briggs@cecer.army.mil>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Briggs <s-briggs@cecer.army.mil> wrote:
>
> This patch adds a module paramter, "auto_neg" which is
>  by default =1.  If it's set to zero, the auto negotiation
>  code in ns83820_init_one() is skipped and the interface is
>  set to 1000F.

Better to do this via `ethtool autoneg off'.
