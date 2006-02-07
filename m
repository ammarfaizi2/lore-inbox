Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWBGJuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWBGJuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWBGJuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:50:14 -0500
Received: from mailgw4.ericsson.se ([193.180.251.62]:59025 "EHLO
	mailgw4.ericsson.se") by vger.kernel.org with ESMTP id S964830AbWBGJuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:50:12 -0500
Date: Tue, 7 Feb 2006 10:45:02 +0100 (CET)
From: Per Liden <per.liden@ericsson.com>
X-X-Sender: eperlid@ulinpc219.uab.ericsson.se
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, Jon Maloy <jon.maloy@ericsson.com>,
       Allan Stephens <allan.stephens@windriver.com>,
       tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] net/tipc/: possible cleanups
In-Reply-To: <20060204011002.GZ4408@stusta.de>
Message-ID: <Pine.LNX.4.64.0602071043550.15267@ulinpc219.uab.ericsson.se>
References: <20060204011002.GZ4408@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Feb 2006 09:50:11.0353 (UTC) FILETIME=[E301A890:01C62BCB]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Adrian Bunk wrote:

> This patch contains the following possible cleanups:
> - make needlessly global code static

Good catch.

> - #if 0 the following unused global functions:
>   - name_table.c: tipc_nametbl_print()
>   - name_table.c: tipc_nametbl_dump()
>   - net.c: tipc_net_next_node()

Thanks! I'll apply this to my tree.

/Per
