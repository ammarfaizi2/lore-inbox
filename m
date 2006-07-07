Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWGGLZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWGGLZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWGGLZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:25:41 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:9146 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S1751096AbWGGLZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:25:41 -0400
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
Date: Fri, 07 Jul 2006 21:25:37 +1000
Message-Id: <1152271537.5163.4.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There was a race in ondemand and conservative which made them lock up on 
> resume (possibly only on SMP systems though).  There's a patch for that 
> in current -mm, but I suspect there's another problem (still haven't had 
> any time to track it down).

OK, I tried the patch with 2.6.17 and it didn't work. My laptop failed
to resume on the first try, so it must be something else. Could someone
actually have a look at the changes in 2.6.12-rc5-git6 (which happen to
be cpufreq-related)? I spend months pinpointing the problem to that
version (it's takes several days to reproduce). I'd appreciate if
someone could at least have a look at what changed there and maybe fix
it.

Thanks,

	Jean-Marc

