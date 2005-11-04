Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbVKDKHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbVKDKHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 05:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVKDKHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 05:07:00 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:55171 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161130AbVKDKG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 05:06:59 -0500
Date: Fri, 4 Nov 2005 02:06:34 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, pbadari@gmail.com, torvalds@osdl.org, jdike@addtoit.com,
       rob@landley.net, nickpiggin@yahoo.com.au, gh@us.ibm.com,
       kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com, mel@csn.ul.ie,
       mbligh@mbligh.org, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [patch] swapin rlimit
Message-Id: <20051104020634.592dd38b.pj@sgi.com>
In-Reply-To: <20051104080731.GB21321@elte.hu>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	<200511021747.45599.rob@landley.net>
	<43699573.4070301@yahoo.com.au>
	<200511030007.34285.rob@landley.net>
	<20051103163555.GA4174@ccure.user-mode-linux.org>
	<1131035000.24503.135.camel@localhost.localdomain>
	<20051103205202.4417acf4.akpm@osdl.org>
	<20051104072628.GA20108@elte.hu>
	<20051103233628.12ed1eee.akpm@osdl.org>
	<20051104080731.GB21321@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> Seriously, while nr_swapped_in_pages ought to be OK, i think there is a 
> generic problem with /proc based stats.
> 
> System instrumentation people are already complaining about how costly 
> /proc parsing is. If you have to get some nontrivial stat from all 
> threads in the system, and if Linux doesnt offer that counter or summary 
> by default, it gets pretty expensive.

Agreed.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
