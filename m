Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbTB1Hz1>; Fri, 28 Feb 2003 02:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbTB1Hz1>; Fri, 28 Feb 2003 02:55:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:43156 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267595AbTB1Hz0>;
	Fri, 28 Feb 2003 02:55:26 -0500
Date: Fri, 28 Feb 2003 00:06:34 -0800
From: Andrew Morton <akpm@digeo.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: kernel@kolivas.org, dmccr@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: Rising io_load results Re: 2.5.63-mm1
Message-Id: <20030228000634.6d23a30c.akpm@digeo.com>
In-Reply-To: <200302280846.04002.baldrick@wanadoo.fr>
References: <20030227025900.1205425a.akpm@digeo.com>
	<20030227160656.40ebeb93.akpm@digeo.com>
	<200302281128.06840.kernel@kolivas.org>
	<200302280846.04002.baldrick@wanadoo.fr>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 08:05:38.0648 (UTC) FILETIME=[2E1D9580:01C2DF00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands <baldrick@wanadoo.fr> wrote:
>
> Hi Con, are you sure this is not the same for 2.5.63?
> I left 2.5.63 running over night (doing nothing but run
> KDE), and in the morning it was swapping heavily.
> About 200MB was swapped out and this did not reduce
> with usage.  According to top, 10% of memory was being
> used by a Konsole with nothing in it (could be a memory
> leak in Konsole).  After half an hour I gave up - it was
> too unusable.  Maybe -mm1 just accentuates a problem
> that is already there in 2.5.63.
> 

Please take a snapshot of /proc/meminfo and /proc/slabinfo
if anything like this happens.
