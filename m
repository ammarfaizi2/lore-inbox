Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273210AbRIWDCc>; Sat, 22 Sep 2001 23:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273230AbRIWDCW>; Sat, 22 Sep 2001 23:02:22 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:37653 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273210AbRIWDCN>; Sat, 22 Sep 2001 23:02:13 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Roger Larsson <roger.larsson@norran.net>
Cc: safemode <safemode@speakeasy.net>,
        Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        george anzinger <george@mvista.com>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200109230042.f8N0gw129012@mailf.telia.com>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org>
	<20010922211919Z272247-760+15646@vger.kernel.org>
	<200109222340.BAA37547@blipp.internet5.net> 
	<200109230042.f8N0gw129012@mailf.telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 22 Sep 2001 23:02:05 -0400
Message-Id: <1001214128.873.26.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-22 at 20:38, Roger Larsson wrote:
> Riels schedule in __alloc_pages probably helps the case with competing
> regular processes a lot. Not allowing memory allocators to run their
> whole time slot. The result should be a way to prioritize memory allocs
> relative your priority. (yield part might be possible/good to remove)

When did this go in?  I assume its in the 2.4.9-ac series and not
2.4.10?

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

