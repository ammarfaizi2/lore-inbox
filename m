Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135511AbRDYPgc>; Wed, 25 Apr 2001 11:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135852AbRDYPgW>; Wed, 25 Apr 2001 11:36:22 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:9873 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135511AbRDYPgP>; Wed, 25 Apr 2001 11:36:15 -0400
Message-ID: <3AE6EEE3.ACE4F18F@coplanar.net>
Date: Wed, 25 Apr 2001 11:36:03 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Event tools, do they exist
In-Reply-To: <3AE61FF2.DF9849BB@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think all of this has been done... you should check out
the Linux Trace Toolkit.

george anzinger wrote:

> This is an attempt to look in the wheel locker.
>
> I need a simple event sub system for use in the kernel.  I envision at
> least two types of events: the history event and the timing event.
>
> The timing event would keep track of start/stop times by class.  If, for
> example, I wanted to know how much time the kernel spends doing the
> recalc in schedule() I would put and event start in front of it and an
> end at the other end.  The sub system would note the first event time
> and the cumulative time between all starts and stops on the same event.
> When reported by /proc/ it would give the total event time, the elapsed
> time and the % of processor time for each of the possibly several
> classes.
>
> The history event would record each events time, location, data1,
> data2.  It would keep N of these (the last N) and report M (M=<N) via
> /proc/.  This list should also be kept in a format that a simple
> debugger can easily examine.
>
> Somebody must have written these routines and have them in their
> library.  Sure would help if I could have a peek.

