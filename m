Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270493AbTGNBmW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270494AbTGNBmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:42:22 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:52137 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S270493AbTGNBmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:42:17 -0400
Date: Mon, 14 Jul 2003 13:54:44 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
	enhancements
In-reply-to: <20030713210934.GK570@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058147684.2400.9.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net>
 <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk>
 <20030713193114.GD570@elf.ucw.cz> <1058130071.1829.2.camel@laptop-linux>
 <20030713210934.GK570@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay. 

Having listened to the arguments, I'll make pressing Escape to cancel
the suspend a feature which defaults to being disabled and can be
enabled via a proc entry in 2.4. I won't add code to poll for ACPI (or
APM) events :>

Regards,

Nigel

On Mon, 2003-07-14 at 09:09, Pavel Machek wrote:
> Hi!
> 
> > Escape is more intuitively obvious though - I would expect the suspend
> > button to only start a suspend. And the idea of escape cancelling
> > anything is well in-grained in peoples' minds.
> 
> You did not initiate suspend from keyboard => you should not
> terminate it from keyboard.
> 
> 								Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

