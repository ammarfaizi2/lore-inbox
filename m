Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTDEBx7 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbTDEBx7 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:53:59 -0500
Received: from [12.47.58.55] ([12.47.58.55]:32088 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261675AbTDEBx6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:53:58 -0500
Date: Fri, 4 Apr 2003 18:06:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030404180620.4677b966.akpm@digeo.com>
In-Reply-To: <20030405013143.GJ16293@dualathlon.random>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain>
	<20030404105417.3a8c22cc.akpm@digeo.com>
	<20030404214547.GB16293@dualathlon.random>
	<20030404150744.7e213331.akpm@digeo.com>
	<20030405000352.GF16293@dualathlon.random>
	<20030404163154.77f19d9e.akpm@digeo.com>
	<20030405013143.GJ16293@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 02:05:22.0575 (UTC) FILETIME=[D0CD99F0:01C2FB17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > - get_unmapped_area() search complexity.
> > 
> >   Solved by remap_file_pages and by as-yet unimplemented algorithmic rework.
> 
> what is this "yet unimplemented algorithmic rework".

I was referring to your planned mmap speedup.  I should have said 'or', nor
'and'.

