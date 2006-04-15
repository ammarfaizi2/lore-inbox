Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWDOFzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWDOFzt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 01:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWDOFzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 01:55:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21228 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030263AbWDOFzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 01:55:49 -0400
Date: Fri, 14 Apr 2006 22:55:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc: fix section mismatch warnings
Message-Id: <20060414225528.4ec40510.akpm@osdl.org>
In-Reply-To: <20060414224439.b9a91323.rdunlap@xenotime.net>
References: <20060414224439.b9a91323.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> This still leaves 5 other PCI-related section mismatches, but I
>  don't think that they are a real problem unless there are some
>  hotplug-parport cards out there.  If needed, I'll fix those too.

It would be good to do so, please.  Ideally we'll end up with zero such
warnings, so any ones which newly appear will be obvious, so nobody will
ever submit a patch which generates new warnings (hah).

