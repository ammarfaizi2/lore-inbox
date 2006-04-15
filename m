Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWDOGEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWDOGEp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 02:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWDOGEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 02:04:45 -0400
Received: from xenotime.net ([66.160.160.81]:51913 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030255AbWDOGEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 02:04:44 -0400
Date: Fri, 14 Apr 2006 23:07:09 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc: fix section mismatch warnings
Message-Id: <20060414230709.33b2f877.rdunlap@xenotime.net>
In-Reply-To: <20060414225528.4ec40510.akpm@osdl.org>
References: <20060414224439.b9a91323.rdunlap@xenotime.net>
	<20060414225528.4ec40510.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006 22:55:28 -0700 Andrew Morton wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> >
> > This still leaves 5 other PCI-related section mismatches, but I
> >  don't think that they are a real problem unless there are some
> >  hotplug-parport cards out there.  If needed, I'll fix those too.
> 
> It would be good to do so, please.  Ideally we'll end up with zero such
> warnings, so any ones which newly appear will be obvious, so nobody will
> ever submit a patch which generates new warnings (hah).

OK, just drop this one, please, and I'll send a replacement
patch.

---
~Randy
