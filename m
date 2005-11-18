Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVKRBxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVKRBxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVKRBxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:53:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750853AbVKRBxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:53:53 -0500
Date: Thu, 17 Nov 2005 17:50:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
 i386
Message-Id: <20051117175015.6aa99fcf.akpm@osdl.org>
In-Reply-To: <20051118014055.GK11494@stusta.de>
References: <20051118014055.GK11494@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
> on i386.
> 

Problem is, nobody's fixing these things.  There's no point in adding spam
to the kernel build unless it actually gets us some action, and I haven't
seen any evidence that it does.

Stick it under CONFIG_I_AM_A_DEVELOPER_WHO_HAS_TIME_TO_FIX_STUFF.

