Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTKAAr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 19:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTKAAr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 19:47:29 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:6329 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262099AbTKAAr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 19:47:28 -0500
Subject: Cyclic Scheduling for linux
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: linuxquestasu@yahoo.com
Content-Type: text/plain
Organization: 
Message-Id: <1067646722.2560.259.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 Oct 2003 19:32:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am working on providing a cyclic scheduling policy
> to the current non real time version of the linux to
> support hard real time tasks as part of one of my
> projects. This policy should be able to support
> aperiodic, periodic and sporadic tasks too. Could any
> one pour some light on how to go about achieving it?.
>
> Any Helpful tips, project reports, links or advices
> are greatly appreciated.

I suppose you expect to write this, but if not,
you can get it in Concurrent's Red Hawk Linux
product.

Marketing says:

"RedHawk's Frequency-Based Scheduler (FBS) is a
high-resolution task scheduler that enables the
user to run processes in cyclical execution patterns.
FBS can control the periodic execution of multiple,
coordinated processes utilizing major and minor
cycles with overrun detection. A performance
monitor is also provided to view CPU utilization
during each scheduled execution frame."

That's on a "real" Linux kernel, not like RTAI
or RT-Linux. There are some other cool real-time
features as well, and an Ada compiler if you're
so inclined.


