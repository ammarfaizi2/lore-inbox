Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161370AbWG1XSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161370AbWG1XSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbWG1XSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:18:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5557 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161365AbWG1XSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:18:11 -0400
Date: Sat, 29 Jul 2006 01:17:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>
Subject: Re: Generic battery interface
Message-ID: <20060728231756.GA4230@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com> <20060728202359.GB5313@suse.cz> <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> And then we have to maintain both a kernel side and a userspace side.
> >> And what do I, poor author of tp_smapi, do if I want to add a
> >> non-standard attribute? Tell people to patch and overwrite their
> >> disto's batstate binary too?
> >
> >How often do you plan to do that?
> 
> With tp_smapi, I did it about 10 times over half a year. And there's
> probably more to come.

I still like /sys approach a bit more, but a word of warning: "it is
hard to change kernel<->user interface" is actually a feature.

It sucks when you are the one doing the work, but maybe it will mean
reusing interfaces where possible.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
