Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbTDGQ20 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTDGQ20 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:28:26 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:39376 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S263521AbTDGQ2Z (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:28:25 -0400
Date: Mon, 7 Apr 2003 18:40:00 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm2
In-Reply-To: <20030403132243.7bc9a22d.akpm@digeo.com>
Message-ID: <Pine.LNX.4.51.0304071833530.18350@dns.toxicfilms.tv>
References: <20030401000127.5acba4bc.akpm@digeo.com>
 <Pine.LNX.4.51.0304031947321.16306@dns.toxicfilms.tv> <20030403132243.7bc9a22d.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you try 2.5.66-mm3?  It has a CPU scheduler fix which might well
> help here.
Hi,

i am using mm3 now.

i think i know what my problem really is, i have 128MB of ram and about
160MB of swap space. Should not i have 2.5 times more that RAM?  Like
320MB. That could lead to enormous swapping. But still the lockups are
curious - even with ram outages and little swap space i should be getting
lots of continuos hdd load, which i do, but why would the system lockup
for 10 seconds with no disk activity?

I tried turning /proc/sys/vm/swappines to 0, and other values between 0
and 60. Also tried /proc/sys/vm/dirty_ratio 15 like you suggested, with
the same effects.

I will try to get more swap space, or maybe ram too and see if it helps.

Regards,
Maciej

