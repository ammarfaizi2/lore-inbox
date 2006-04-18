Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWDRWTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWDRWTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWDRWTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:19:17 -0400
Received: from test-iport-2.cisco.com ([171.71.176.105]:53597 "EHLO
	test-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750757AbWDRWTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:19:16 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
X-Message-Flag: Warning: May contain useful information
References: <20060418220715.GO11582@stusta.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 18 Apr 2006 15:19:14 -0700
In-Reply-To: <20060418220715.GO11582@stusta.de> (Adrian Bunk's message of "Wed, 19 Apr 2006 00:07:15 +0200")
Message-ID: <adad5feedct.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 Apr 2006 22:19:14.0293 (UTC) FILETIME=[20009250:01C66336]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Adrian> As an example, the only usage of bus_to_virt() in the
    Adrian> infiniband code was added in 2.6.17-rc1 (sic).

Ugh, the pathscale guys snuck that one past me in the ipath merge.
I'll see what I can do about it...

 - R.
