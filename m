Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUCQAap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUCQAap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:30:45 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:4483 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261866AbUCQAal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:30:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Tue, 16 Mar 2004 19:30:35 -0500
User-Agent: KMail/1.6.1
Cc: acpi-devel@lists.sourceforge.net, Karol Kozimor <sziwan@hell.org.pl>,
       lkml <linux-kernel@vger.kernel.org>
References: <20040316182257.GA2734@dreamland.darkstar.lan> <200403161819.55351.dtor_core@ameritech.net> <1079479950.5408.53.camel@cog.beaverton.ibm.com>
In-Reply-To: <1079479950.5408.53.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403161930.35110.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 March 2004 06:32 pm, john stultz wrote:
> On Tue, 2004-03-16 at 15:19, Dmitry Torokhov wrote:
> > PM timer does not install CPUFREQ handler which would scale cpu_khz to
> > give proper display. I might cook up something later tonight.
> 
> Actually, the cpufreq handler is installed by an initcall regardless of
> which time-source is used. However as the handler changes a few TSC
> specific variables, it exits in timer_tsc.c.
>

Yes, you are of course right, I missed that fact, sorry.

-- 
Dmitry
