Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWGPAXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWGPAXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 20:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWGPAXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 20:23:16 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:25553 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S964818AbWGPAXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 20:23:15 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152978284.16617.7.camel@mindpipe>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
	 <1152971896.16617.4.camel@mindpipe>
	 <1152973159.6374.59.camel@idefix.homelinux.org>
	 <1152974578.3114.24.camel@laptopd505.fenrus.org>
	 <1152975857.6374.65.camel@idefix.homelinux.org>
	 <1152978284.16617.7.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sun, 16 Jul 2006 10:23:11 +1000
Message-Id: <1153009392.6374.77.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think it's a problem.  If the admin does not want non-root users
> to be able to lock up the machine, just don't put them in the realtime
> group.

What if the admin *wants* non-root users to have good quality audio, and
just doesn't want them to crash the system (voluntarily and especially
accidentally). Enforcing CPU limits *is* possible and it has already
been done independently by both Ingo and Con. I'm just waiting for the
feature to be available out-of-the box, which is not for today if kernel
space keeps pointing at userspace and vice versa. :-(

	Jean-Marc
