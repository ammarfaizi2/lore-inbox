Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUC0NtU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 08:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUC0NtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 08:49:20 -0500
Received: from mail.shareable.org ([81.29.64.88]:18578 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261717AbUC0NtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 08:49:19 -0500
Date: Sat, 27 Mar 2004 13:49:02 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/22] /dev/random: kill unrolled SHA code
Message-ID: <20040327134902.GC21884@mail.shareable.org>
References: <16.524465763@selenic.com> <40638AB1.7080201@pobox.com> <20040326035905.GE8366@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326035905.GE8366@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> > So we go from "fast" to "I hope it gets faster in the future"?
> 
> No, we go from "moderately fast and dead code duplicated in /crypto"
> to "same speed and one step closer to merging with /crypto". This bit
> can be dropped for now, I've got the other bits deeper in my queue.

I suggest applying this patch.  All it does is delete unused code.

-- Jamie
