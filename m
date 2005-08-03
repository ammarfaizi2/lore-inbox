Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVHCGO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVHCGO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVHCGO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:14:58 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:40897 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262072AbVHCGO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:14:58 -0400
Date: Wed, 3 Aug 2005 08:14:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bill Davidsen <davidsen@tmr.com>
cc: Dave Jones <davej@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i387 floating-point test program/benchmark
In-Reply-To: <42EFBAB2.7090908@tmr.com>
Message-ID: <Pine.LNX.4.61.0508030814000.2263@yvahk01.tjqt.qr>
References: <200507291639_MC3-1-A5E6-856D@compuserve.com>
 <20050729221518.GB20253@redhat.com> <42EFBAB2.7090908@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Among other issues.
>
> Therefore: add_tail(spare_time_Q);
>
> oddball:davidsen> cc -o i387bench -Os i387_bench.c
> i387_bench.c:27: parse error before `cpuset'
> i387_bench.c:27: warning: data definition has no type or storage class

This looks like an "old" glibc that does not have cpuset yet.

> i387_bench.c:34: unknown field `sa_handler' specified in initializer

Maybe a missing #include <signal.h>?


Jan Engelhardt
-- 
