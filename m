Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVKNKVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVKNKVN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 05:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVKNKVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 05:21:13 -0500
Received: from [85.8.13.51] ([85.8.13.51]:40346 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751069AbVKNKVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 05:21:13 -0500
Message-ID: <4378650A.1070209@drzeus.cx>
Date: Mon, 14 Nov 2005 11:20:58 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051114021127.GC5735@stusta.de>
In-Reply-To: <20051114021127.GC5735@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> It seems most problems with 4k stacks are already resolved.
> 
> I'd like to see this patch to always use 4k stacks in -mm now for 
> finding any remaining problems before submitting this patch for 2.6.16.
> 
> 

Has the block layer been remade to a serial approach? Last time I 
checked you could exhaust the stack fairly easy by layering a couple of 
block subsystems on each other (usb+scsi+raid+lvm+xfs+nfs to make things 
as horrible as possible).

Rgds
Pierre

