Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVAGCgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVAGCgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVAGCgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 21:36:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:59557 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261185AbVAGCgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 21:36:32 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <20050107011820.GC2995@waste.org>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>
	 <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de>
	 <1104898693.24187.162.camel@localhost.localdomain>
	 <20050107011820.GC2995@waste.org>
Content-Type: text/plain
Date: Thu, 06 Jan 2005 21:36:30 -0500
Message-Id: <1105065390.16117.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 17:18 -0800, Matt Mackall wrote:
> Why can't this be done with a simple SUID helper to promote given
> tasks to RT with sched_setschedule, doing essentially all the checks
> this LSM is doing? 
> 
> Objections of "because it requires dangerous root or suid" don't fly,
> an RT app under user control can DoS the box trivially. Never mind you
> need root to configure the LSM anyway..

Yes but a bug in an app running as root can trash the filesystem.  The
worst you can do with RT privileges is lock up the machine.

Lee

