Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbTIMP4r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 11:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbTIMP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 11:56:47 -0400
Received: from gprs148-167.eurotel.cz ([160.218.148.167]:63872 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261273AbTIMP4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 11:56:46 -0400
Date: Sat, 13 Sep 2003 17:56:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Pau Aliagas <linuxnow@newtral.org>
Cc: Claas Langbehn <claas@rootdir.de>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew de Quincey <adq@lidskialf.net>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [2.6.0-test5-mm1] Suspend to RAM problems
Message-ID: <20030913155626.GB527@elf.ucw.cz>
References: <20030910154551.GA1507@rootdir.de> <Pine.LNX.4.44.0309101806480.2528-100000@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309101806480.2528-100000@pau.intranet.ct>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > 2) ACPI
> > > > Thanks to Andrew de Quincey I can boot with ACPI without
> > > > problems and I can read out my temp and so on, but when I do
> > > >    echo -n "mem" >/sys/power/state 
> > > > the machine goes into sleep (STR) but crashes after waking up again.
> > > 
> > > What exactly does it do on wakeup? 
> 
> Mine crashes before suspending. It says something like:
> Stoppings tasks
> ===========================================================
> critical region / count pages [XXXXXXXXXXXX]

This looks like swsusp, not S3.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
