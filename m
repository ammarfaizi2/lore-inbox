Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWEAHSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWEAHSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWEAHSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:18:31 -0400
Received: from mail.suse.de ([195.135.220.2]:16819 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751292AbWEAHSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:18:30 -0400
From: Neil Brown <neilb@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Date: Mon, 1 May 2006 17:18:19 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17493.46651.168919.653727@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/sync.c: make do_sync_file_range() static
In-Reply-To: message from Adrian Bunk on Monday May 1
References: <20060501071125.GD3570@stusta.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 1, bunk@stusta.de wrote:
> This patch makes the needlessly global do_sync_file_range() static.

I'm planning to use that in nfsd.  Just haven't got there yet.

NeilBrown
