Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264874AbUEUXCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUEUXCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUEUWuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:50:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:36774 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264495AbUEUWtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:49:09 -0400
Date: Fri, 21 May 2004 13:10:21 +0100
From: Dave Jones <davej@redhat.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
Message-ID: <20040521121021.GA23750@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com> <Pine.LNX.4.58.0405210101200.2864@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405210101200.2864@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 01:06:23AM -0400, Zwane Mwaikambo wrote:

 > Processor #0 5:2 APIC version 16
 > Processor #3 5:2 APIC version 16
 > Processor #4 5:2 APIC version 16

I'd argue these are of little value as long as they work.
(and we printk a different message iirc if they are unknown to us)

 > Enabling APIC mode:  Flat.  Using 2 I/O APICs

ditto

 > Processors: 3

a 3-way? cute.

 > Built 1 zonelists

useful ?

 > kernel profiling enabled

feh. if we cared, we could check /proc/profile or
look for oprofilefs

 > PID hash table entries: 1024 (order 10: 8192 bytes)

kern_debug ?

 > Calibrating delay loop... 254.97 BogoMIPS

yawn

 > POSIX conformance testing by UNIFIX

I thought this got nuked already

 > Calibrating delay loop... 266.24 BogoMIPS
 > Calibrating delay loop... 265.21 BogoMIPS
 > Total of 3 processors activated (786.43 BogoMIPS).

Maybe just keep the last line ? kern_boring the others.

		Dave

