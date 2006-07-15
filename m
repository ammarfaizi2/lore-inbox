Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946051AbWGOOTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946051AbWGOOTW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 10:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946052AbWGOOTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 10:19:22 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:8612 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S1946051AbWGOOTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 10:19:21 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152971896.16617.4.camel@mindpipe>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
	 <1152971896.16617.4.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sun, 16 Jul 2006 00:19:18 +1000
Message-Id: <1152973159.6374.59.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Non-root RT tasks are not "unprivileged" - they have a level of
> privileges between a normal user and root.  Really I think it's OK for
> these tasks to consume 100% CPU, as the admin has explicitly allowed it.

Sure, if the admin has allowed it, but I think it's also OK for desktop
users to have access to rt scheduling by default, as long as their tasks
are "well-behaved" (i.e. only use a few percent CPU).

> The only problem is that Ubuntu shipped with this enabled for everyone.

The problem is not the fact that it's enabled, but the fact that the
amount of CPU allowed isn't restricted.

	Jean-Marc
