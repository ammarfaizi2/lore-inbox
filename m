Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVKKImG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVKKImG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVKKImF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:42:05 -0500
Received: from [85.8.13.51] ([85.8.13.51]:43160 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932242AbVKKIlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:41:51 -0500
Message-ID: <43745942.7010708@drzeus.cx>
Date: Fri, 11 Nov 2005 09:41:38 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.6a1 (X11/20051022)
MIME-Version: 1.0
To: Pierre Ossman <drzeus@drzeus.cx>
CC: akpm@osdl.org, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Add try_to_freeze to kauditd
References: <20051107071300.7073.47106.stgit@poseidon.drzeus.cx>
In-Reply-To: <20051107071300.7073.47106.stgit@poseidon.drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> kauditd was causing suspends to fail because it refused to freeze.
> Adding a try_to_freeze() to its sleep loop solves the issue.
>
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> Acked-by: Pavel Machek <pavel@suse.cz>
> ---
>   


This has of course nothing to do with [MMC]. Andrew, could you strip 
this of the patch before you add it to your set?

Rgds
Pierre

