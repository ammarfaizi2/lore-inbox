Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTJUIZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbTJUIZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:25:23 -0400
Received: from main.gmane.org ([80.91.224.249]:30650 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263024AbTJUIZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:25:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCHSET] 0/3 Dynamic cpufreq governor and updates to ACPI
 P-state driver
Date: Tue, 21 Oct 2003 10:25:10 +0200
Message-ID: <yw1xoewb6lqx.fsf@kth.se>
References: <88056F38E9E48644A0F562A38C64FB60077911@scsmsx403.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:gEmNqpGrKZttxIK19CklkTKzpQo=
Cc: cpufreq@www.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:

> Most of the latest CPUs (laptop CPUs in particular) have feature 
> which enable very low latency P-state transitions 
> (like Enhanced Speedstep Technology-EST). Using this feature, 
> we can have a lightweight in kernel cpufreq governor, 
> to vary CPU frequency depending on the CPU usage. The 
> advantage being low power consumption and also cooler laptops.

So, how does this work?  I'd like to be able to set minimum and
maximum clock frequencies to allow, and CPU utilization thresholds at
which to switch frequencies.  Is that possible, or is it work yet to
be done?  Adjustable polling interval would also be nice.

> The patches will work on all laptops with EST technology 
> (Centrino) and also on any other system that supports low 
> latency frequency change. 

Does Pentium 4 M work?

-- 
Måns Rullgård
mru@kth.se

