Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRCWByO>; Thu, 22 Mar 2001 20:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRCWByF>; Thu, 22 Mar 2001 20:54:05 -0500
Received: from [204.244.205.25] ([204.244.205.25]:56142 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S129164AbRCWBxz>;
	Thu, 22 Mar 2001 20:53:55 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
From: Michael Peddemors <michael@linuxmagic.com>
To: Stephen Clouse <stephenc@theiqgroup.com>
Cc: Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010322142831.A929@owns.warpcore.org>
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com>
	<Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva>
	<20010322124727.A5115@win.tue.nl>  <20010322142831.A929@owns.warpcore.org>
Content-Type: text/plain
X-Mailer: Evolution (0.9 - Preview Release)
Date: 22 Mar 2001 17:31:57 -0800
Mime-Version: 1.0
Message-Id: <20010323015358Z129164-406+3041@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here, Here.. killing qmail on a server who's sole task is running mail doesn't seem to make much sense either..

> > Clearly, Linux cannot be reliable if any process can be killed

> > at any moment. I am not happy at all with my recent experiences.
> 
> Really the whole oom_kill process seems bass-ackwards to me.  I can't in my mind
> logically justify annihilating large-VM processes that have been running for 
> days or weeks instead of just returning ENOMEM to a process that just started 
> up.
> 
> We run Oracle on a development box here, and it's always the first to get the
> axe (non-root process using 70-80 MB VM).  Whenever someone's testing decides to 
> run away with memory, I usually spend the rest of the day getting intimate with
> the backup files, since SIGKILLing random Oracle processes, as you might have
> guessed, has a tendency to rape the entire database.

-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
WizardInternet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada

