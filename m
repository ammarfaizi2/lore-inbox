Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272377AbTGYXQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272378AbTGYXQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:16:24 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:37066 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272377AbTGYXQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:16:20 -0400
Date: Sat, 26 Jul 2003 01:31:22 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: =?iso-8859-1?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G3
Message-ID: <20030726013122.B2326@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: =?iso-8859-1?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307252146550.16235-100000@localhost.localdomain> <20030725231314.A1073@ss1000.ms.mff.cuni.cz> <20030726005419.16b622af.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030726005419.16b622af.diegocg@teleline.es>; from diegocg@teleline.es on Sat, Jul 26, 2003 at 12:54:19AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cpumask_of_cpu is not declared/used anywhere in the kernel (apart
> of kernel/sched.c:2498, after applying bk2 + your patch)

Oh, well. I'd better go to sleep.

I suppose you figured out that you have to change that to 1ULL << cpu . Just in
case you didn't, get the right one at
http://www.ms.mff.cuni.cz/~thomr9am/sched-2.6.0-test1-bk2-G3 .

Rudo.
