Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270692AbTGNScu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTGNScu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:32:50 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:7155 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S270692AbTGNSci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:32:38 -0400
Date: Tue, 15 Jul 2003 06:44:49 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
	enhancements
In-reply-to: <m2llv1t3qs.fsf@tnuctip.rychter.com>
To: Jan Rychter <jan@rychter.com>
Cc: Pavel Machek <pavel@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058208288.23915.3.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net>
 <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk>
 <20030713193114.GD570@elf.ucw.cz> <1058130071.1829.2.camel@laptop-linux>
 <20030713210934.GK570@elf.ucw.cz> <1058147684.2400.9.camel@laptop-linux>
 <20030714131132.GD221@elf.ucw.cz> <m2llv1t3qs.fsf@tnuctip.rychter.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

It defaults to disabled precisely because of Pavel's concerns.

Regards,

Nigel

On Tue, 2003-07-15 at 05:30, Jan Rychter wrote:
> >>>>> "Pavel" == Pavel Machek <pavel@suse.cz> writes:
>  Pavel> Hi!
>  >> Having listened to the arguments, I'll make pressing Escape to
>  >> cancel the suspend a feature which defaults to being disabled and
>  >> can be enabled via a proc entry in 2.4. I won't add code to poll for
>  >> ACPI (or APM) events :>
> 
>  Pavel> At least no new proc entry, please. Make it depend on
>  Pavel> sysrq_enabled and disable it completely if sysrq support is not
>  Pavel> compiled in.
> 
> Pavel, I disagree. This is important functionality. I *do* want to abort
> suspends by pressing 'Esc'.
> 
> I do not believe that hiding this gives you any extra security, and I do
> not believe that having it in is any kind of a problem. None of your
> arguments against it convinced me.
> 
> Please do not try to hide it and obscure it any more than it already is
> (Nigel has made this default to off for some reason).
> 
> --J.
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

