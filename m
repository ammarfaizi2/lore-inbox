Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTDDSGI (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTDDSGI (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:06:08 -0500
Received: from [12.47.58.55] ([12.47.58.55]:17659 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263808AbTDDSGG (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:06:06 -0500
Date: Fri, 4 Apr 2003 10:18:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: dmccr@us.ibm.com, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] tweaks for page_convert_anon
Message-Id: <20030404101823.2a63bb02.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0304041735150.1980-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304041735150.1980-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 18:17:29.0411 (UTC) FILETIME=[73E4B930:01C2FAD6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Also, page_convert_anon remember pte_unmap after successful find_pte.

gack.

OK, thanks.  I've dropped my current rollup against 2.5.66 at

http://www.zip.com.au/~akpm/linux/patches/2.5/hd.patch.gz
