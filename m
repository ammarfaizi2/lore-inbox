Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317559AbSGTWuS>; Sat, 20 Jul 2002 18:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317560AbSGTWuR>; Sat, 20 Jul 2002 18:50:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:22515 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317559AbSGTWuR>; Sat, 20 Jul 2002 18:50:17 -0400
Date: Sat, 20 Jul 2002 15:48:59 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@transmeta.com>
cc: William Lee Irwin III <wli@holomorphy.com>, akpm@zip.com.au,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] for_each_pgdat
Message-ID: <244469929.1027180137@[10.10.2.3]>
In-Reply-To: <1027201039.1085.812.camel@sinai>
References: <1027201039.1085.812.camel@sinai>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ok guys, you three (and whoever else wants to play? ;) fight it out amonst
>> yourselves, I'll wait for the end result (iow: I'll just ignore both
>> patches for now).
> 
> No no... the issues are fairly orthogonal.
> 
> Attached is a patch with the for_each_pgdat implementation and
> s/node_next/pgdat_next/ per Martin.

I'm happy with this (obviously ;-))
 
> If Bill wants to convert pgdats to lists that is fine but is another
> step.  Let's get in this first batch and that can be done off this.

As we now reference them in only two places (the macro defn and
numa.c:_alloc_pages) it hardly seems worth converting to lists ... ? 
(I'm going to take an axe to NUMA _alloc_pages in a minute anyway ;-))

M.
