Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUC1TsC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUC1TsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:48:02 -0500
Received: from ns.suse.de ([195.135.220.2]:3741 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262391AbUC1TsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:48:00 -0500
To: David Mosberger <davidm@napali.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: replace MAX_MAP_COUNT with /proc/sys/vm/max_map_count
References: <16485.5722.591616.846576@napali.hpl.hp.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Mar 2004 07:19:49 +0100
In-Reply-To: <16485.5722.591616.846576@napali.hpl.hp.com.suse.lists.linux.kernel>
Message-ID: <p733c7uak1m.fsf@nielsen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> writes:
>  
>  int sysctl_overcommit_memory = 0;	/* default is heuristic overcommit */
>  int sysctl_overcommit_ratio = 50;	/* default is 50% */
> +int sysctl_max_map_count = DEFAULT_MAX_MAP_COUNT;

I think it would be better to scale the default by available low mem size.

-Andi
