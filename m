Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbTCGFuX>; Fri, 7 Mar 2003 00:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbTCGFuX>; Fri, 7 Mar 2003 00:50:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:51843 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261374AbTCGFuW>;
	Fri, 7 Mar 2003 00:50:22 -0500
Date: Thu, 6 Mar 2003 22:00:53 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: vandrove@vc.cvut.cz, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm_area_struct slab corruption
Message-Id: <20030306220053.1d757ed6.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303070454320.1938-100000@localhost.localdomain>
References: <20030306145223.67d571b1.akpm@digeo.com>
	<Pine.LNX.4.44.0303070454320.1938-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 06:00:49.0880 (UTC) FILETIME=[E75A8580:01C2E46E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> If adding an extra arg, then the extra arg to add would be what Alan
> did in 2.4-ac, int acct to control whether it does the VM_ACCOUNTing.
> I resisted adding that (changing odd distant drivers), and I may have
> been wrong to do so.

This looks pretty simple?  Is it not just a matter of propagating that flag
down to unmap_region()?  I don't see where drivers and such are involved?


