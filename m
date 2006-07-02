Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWGBWw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWGBWw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 18:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWGBWw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 18:52:57 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:9871 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S1751016AbWGBWw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 18:52:57 -0400
Subject: Re: Suspend to RAM regression tracked down
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
In-Reply-To: <44A80B20.1090702@goop.org>
References: <1151837268.5358.10.camel@idefix.homelinux.org>
	 <44A80B20.1090702@goop.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Mon, 03 Jul 2006 08:52:44 +1000
Message-Id: <1151880764.5358.32.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There was a race in ondemand and conservative which made them lock up on 
> resume (possibly only on SMP systems though).  There's a patch for that 
> in current -mm, but I suspect there's another problem (still haven't had 
> any time to track it down).

Any link to the patch and the thread about the problem (if any)? Also,
was the race introduced in 2.6.12-rc5-git6? If not, it's a completely
different problem because my machine worked fine with 2.6.12-rc5-git5.

	Jean-Marc
