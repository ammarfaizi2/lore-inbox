Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261470AbTC0WxQ>; Thu, 27 Mar 2003 17:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbTC0WxQ>; Thu, 27 Mar 2003 17:53:16 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:30435 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S261470AbTC0WxP>; Thu, 27 Mar 2003 17:53:15 -0500
Subject: Re: lm sensors sysfs file structure
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 27 Mar 2003 18:00:51 -0500
Message-Id: <1048806052.10675.4440.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> temp_max[1-3]   Temperature max value.
>                 Fixed point value in form XXXXX and
>                 should be divided by
>                 100 to get degrees Celsius.
>                 Read/Write value.

Celsius can go negative, which may be yucky
and hard to test. Kelvin generally doesn't
suffer this problem. (yeah, yeah, quantum stuff...)

Getting temperature display into "top" would sure
be nice, but not if that means requiring a library
that almost nobody has installed. It's good to give
apps a simple way to get CPU temperature, including
per-CPU data for SMP systems when available.

Info about sensor quality would be good. For example,
my CPU measures temperature in 4-degree increments
and is not calibrated.



