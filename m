Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTAaVRZ>; Fri, 31 Jan 2003 16:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTAaVRY>; Fri, 31 Jan 2003 16:17:24 -0500
Received: from packet.digeo.com ([12.110.80.53]:6120 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262420AbTAaVRY>;
	Fri, 31 Jan 2003 16:17:24 -0500
Date: Fri, 31 Jan 2003 13:29:08 -0800
From: Andrew Morton <akpm@digeo.com>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OSDL][BENCHMARK] OSDL-DBT-2 - 2.4 vs 2.5 4-way/8-way with
 vmstat
Message-Id: <20030131132908.47e47cd6.akpm@digeo.com>
In-Reply-To: <200301312026.h0VKQwp28398@mail.osdl.org>
References: <200301312026.h0VKQwp28398@mail.osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2003 21:26:42.0802 (UTC) FILETIME=[73047520:01C2C96F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
>   Link information:
> 
>   The overall results page for the DBT-2 project is at:
>   http://www.osdl.org/projects/dbt2dev/results
> 
>   direct link to 4 way results page:
>   http://www.osdl.org/projects/dbt2dev/results/STP_4way/STP_4way_2.4v2.5.html
> 
>   direct link to 8 way results page:
>   http://www.osdl.org/projects/dbt2dev/results/8way/LKML2/STP_8way_2.4v2.5.html
>   direct link to 8way results page

There seem to be quite a lot of mangled links there.  For example,
http://www.osdl.org/projects/dbt2dev/results/8way/LKML2/STP_8way_2.4v2.5.html#table0
links to
http:////www.osdl/org/projects/dbt2dev/results/8way/LKML2/c24.html

and
http://www.osdl.org/projects/dbt2dev/results/8way/LKML2/c24.html
links to
http://www.osdl/org/projects/dbt2dev/results/8way/LKML2/data/c24/296/vmstat.out

and when I fix up the latter:
http://www.osdl.org/projects/dbt2dev/results/8way/LKML2/data/c24/296/vmstat.out
it isn't there :(

However the numbers at
http://www.osdl.org/projects/dbt2dev/results/LKML_dbt2_2.4v2.5_both.html#table0

Seem to be showing increased user time in 2.5, decreased system time.  And
zero pgpgin/pgpgout in 2.5, which seems wrong.

I'd really like to see the vmstat traces.  Judging by the reduced idle time
in 2.5, this change could be due to more successful page replacement
decisions.


