Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUJISak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUJISak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 14:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUJISak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 14:30:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11147 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267287AbUJISab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 14:30:31 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: karim@opersys.com
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>,
       Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <416822B7.5050206@opersys.com>
References: <41677E4D.1030403@mvista.com>  <416822B7.5050206@opersys.com>
Content-Type: text/plain
Message-Id: <1097346628.1428.11.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 14:30:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 13:41, Karim Yaghmour wrote:
> Sven-Thorsten Dietrich wrote:
> >     - Voluntary Preemption by Ingo Molnar
> >     - IRQ thread patches by Scott Wood and Ingo Molnar
> >     - BKL mutex patch by Ingo Molnar (with MV extensions)
> >     - PMutex from Germany's Universitaet der Bundeswehr, Munich
> >     - MontaVista mutex abstraction layer replacing spinlocks with mutexes
> 
> To the best of my understanding, this still doesn't provide deterministic
> hard-real-time performance in Linux.

Using only the VP+IRQ thread patch, I ran my RT app for 11 million
cycles yesterday, with a maximum delay of 190 usecs.  How would this not
satisfy a 200 usec hard RT constraint?

PHB:      "I've looked at your proposal and decided it can't be done"
Dilbert:  "I just did it.  It's working perfectly" 

Lee

