Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTFBWGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 18:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTFBWGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 18:06:31 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:3346 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264192AbTFBWGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 18:06:30 -0400
Date: Mon, 2 Jun 2003 15:16:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: [BENCHMARK] 2.5.70-mm2 with contest
Message-Id: <20030602151644.06252b28.akpm@digeo.com>
In-Reply-To: <200306030806.49885.kernel@kolivas.org>
References: <200306030806.49885.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2003 22:19:56.0350 (UTC) FILETIME=[18EAB5E0:01C32955]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> io_load:
> Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.69              4   343     22.7    120.5   19.8    4.29
> 2.5.69-mm3          4   319     24.5    105.3   18.1    4.04
> 2.5.69-mm5          4   137     56.9    49.6    19.0    1.73
> 2.5.69-mm6          4   150     52.0    53.4    18.7    1.92
> 2.5.70              5   326     21.5    112.9   18.7    4.13
> 2.5.70-mm2          4   115     67.0    42.0    19.1    1.47
> large drop in time with one large file write

We're hitting nearly 90% CPU here.  That is really excellent.

> I tried getting runs on 2.5.69-mm9 and 2.5.70-mm1 but ran into BUGs that have 
> been reported before on lkml.

mm3 should be OK.  After several days more testing I have not found any
bugs in mm3's ext3 which are not already in 2.5.70 ;)

