Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWHXEjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWHXEjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 00:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWHXEjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 00:39:24 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:35824 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030280AbWHXEjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 00:39:23 -0400
Message-ID: <44ED2D78.7090304@bigpond.net.au>
Date: Thu, 24 Aug 2006 14:39:20 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Rich Paredes <rparedes@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP Affinity and nice
References: <38798.127.0.0.1.1156346673.squirrel@forexproject.com>	 <Pine.LNX.4.61.0608231735210.9588@yvahk01.tjqt.qr>	 <44ED0121.5080702@bigpond.net.au> <3bfa83ed0608231920h5d9ef2bbxee71badedb38e3f7@mail.gmail.com>
In-Reply-To: <3bfa83ed0608231920h5d9ef2bbxee71badedb38e3f7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Thu, 24 Aug 2006 04:39:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rich Paredes wrote:
> Hi Peter.  2.6.5
> 

OK.  That version does not take tasks' nice values into account when 
doing load balancing and just tries to evenly distribute the tasks among 
the CPUs.  The smpnice patches (to be included in the 2.6.18 kernel) 
change this so that nice is taken into account when load balancing is 
done and should fix your problem.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
