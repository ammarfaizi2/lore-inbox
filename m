Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTAaOvP>; Fri, 31 Jan 2003 09:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTAaOvP>; Fri, 31 Jan 2003 09:51:15 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:50193 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S261354AbTAaOvO>; Fri, 31 Jan 2003 09:51:14 -0500
Date: Fri, 31 Jan 2003 16:00:37 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: "Mike A. Harris" <mharris@redhat.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
In-Reply-To: <Pine.LNX.4.44.0301310907250.893-100000@devel.capslock.lan>
Message-ID: <Pine.LNX.4.51.0301311555540.30372@dns.toxicfilms.tv>
References: <Pine.LNX.4.44.0301310907250.893-100000@devel.capslock.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> compiling the kernel (or anything for that matter) isn't going to
> show any difference really because the CPU Mhz and L1/L2 cache
> are the bottleneck.
How about a test comprising of lots of mail being
sent/rejected/bounced/deferred/etc.
Usually SMTPs like postfix store lots of directories and files in there.
And thus create lots of reads/writes. We could measure the efficiency of
that.
I think it is possible to DoS a system by thrashing its i/o by forcing the
smtp to do lots of work. With very poor io efficiency that is.

Propably reiserfs would have better results with such a test, whereas
ext3 could have better results on a differents test. (different
application)

I think the 'best result' fs will vary on the test.
Also i think it is better to testdrive the file systems using real
applications on high load.

Regards,
Maciej Soltysiak

