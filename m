Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVFACTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVFACTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 22:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVFACSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 22:18:12 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:8343 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261238AbVFACPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 22:15:47 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@muc.de>, Steven Rostedt <rostedt@goodmis.org>,
       karim@opersys.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       hch@infradead.org, dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       James Bruce <bruce@andrew.cmu.edu>, kus Kusche Klaus <kus@keba.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <bhuey@lnxw.com>
Date: Tue, 31 May 2005 19:13:51 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: RT patch acceptance
In-Reply-To: <20050601020627.GD5413@g5.random>
Message-ID: <Pine.LNX.4.62.0505311911110.19864@qynat.qvtvafvgr.pbz>
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk>
 <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com>
 <429B9880.1070604@opersys.com> <20050530224949.GE9972@nietzsche.lynx.com>
 <429B9E85.2000709@opersys.com> <1117556975.2569.37.camel@localhost.localdomain>
 <20050531200114.GD9372@muc.de> <Pine.LNX.4.62.0505311312410.19864@qynat.qvtvafvgr.pbz>
 <20050601020627.GD5413@g5.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Andrea Arcangeli wrote:

> On Tue, May 31, 2005 at 01:14:40PM -0700, David Lang wrote:
>> distros already throw >20% performance improvements on the floor to
>
> hmm, where does that >20% number come from?
>

missed options for optimizing for the specific CPU you have. it's not as 
bad as it used to be when everything was compiled for 386, but it's still 
a significant benifit to recompile with no changes in options except for 
the CPU type.

I haven't measured it recently, but in the 2.4.17/2.6.0 timeframe I was 
seeing >30% for optimized kernels vs stock ones so I don't think the 20% 
figure is unreasonable.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
