Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVBROGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVBROGD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 09:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVBROGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 09:06:03 -0500
Received: from tim.rpsys.net ([194.106.48.114]:19925 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261208AbVBROF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 09:05:58 -0500
Message-ID: <048701c515c2$81ff2d30$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>,
       "James Simmons" <jsimmons@pentafluge.infradead.org>,
       "Adrian Bunk" <bunk@stusta.de>,
       "Linux Input Devices" <linux-input@atrey.karlin.mff.cuni.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <dmitry.torokhov@gmail.com>
References: <20050213004729.GA3256@stusta.de> <Pine.LNX.4.56.0502141756220.7398@pentafluge.infradead.org> <20050214193438.GB7763@ucw.cz> <20050218122217.GA1523@elf.ucw.cz> <047401c515bb$437b5130$0f01a8c0@max> <20050218132651.GA1813@elf.ucw.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Fri, 18 Feb 2005 14:02:25 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek:
> It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
> and it will not work on i386/APM, anyway. I still believe right
> solution is to add input interface to ACPI. /proc/acpi/events needs to
> die, being replaced by input subsystem.

I'm not too familiar with ACPI so I can't really comment on that. The system 
I'm working on only has APM. I think some attempt needs to be made to use 
apm if available. As i386 won't support it, lets drop the i386/APM until it 
does and just keep the arm case.

Regards,

Richard 

