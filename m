Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbVKXJOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVKXJOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVKXJOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:14:06 -0500
Received: from [85.8.13.51] ([85.8.13.51]:32928 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751323AbVKXJOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:14:03 -0500
Message-ID: <4385844C.5080707@drzeus.cx>
Date: Thu, 24 Nov 2005 10:13:48 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: akpm@osdl.org, pavel@suse.cz
CC: linux-kernel@vger.kernel.org
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
>  kernel/audit.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
>   

Did anyone actually pick this up? Its not in -mm or Linus' tree.

Rgds
Pierre

