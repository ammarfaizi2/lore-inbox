Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264333AbUDUBis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbUDUBis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 21:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbUDUBis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 21:38:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27901 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264333AbUDUBif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 21:38:35 -0400
Message-ID: <4085D096.2060103@mvista.com>
Date: Tue, 20 Apr 2004 18:38:30 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] New high resolution time patch for 2.6.5 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The High Resolution Timers patch for the 2.6.5 kernel has just been posted on 
sourceforge.

This patch provides an extension to the POSIX clocks and timers to define two 
new high resolution clocks (CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR).  The 
resolution of these clocks can be set at CONFIGURE time, with the default being 
10 micro seconds.  The high res clocks can be used with clock_nanosleep() as 
well as with the POSIX timers.

This version uses apic timers to obtain much better accuracy and simplicity.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

