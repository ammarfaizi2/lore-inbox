Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbTGOTHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269532AbTGOTHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:07:38 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:19695 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S269530AbTGOTHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:07:35 -0400
Date: Wed, 16 Jul 2003 07:05:26 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
In-reply-to: <20030715172729.GA1491@mail.jlokier.co.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Kent Borg <kentborg@borg.org>, Pavel Machek <pavel@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058295926.1818.9.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net>
 <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk>
 <20030715122336.B12505@borg.org> <20030715172729.GA1491@mail.jlokier.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already activate swsusp using either the sleep button (
/proc/acpi/events -> acpid -> script) or the gkrellm acpi addin that
monitors battery levels. I'm sure acpid could do the lid switch too.

That's for initiating the suspend, of course. As I said, I'm not about
to bloat swsusp further by adding code to test for the switches during
suspend.

Regards,

Nigel

On Wed, 2003-07-16 at 05:27, Jamie Lokier wrote:
> Kent Borg wrote:
> > On Sun, Jul 13, 2003 at 02:35:17PM +0100, Jamie Lokier wrote:
> > > I'd be inclined to initiate suspend-to-disk when the laptop's lid is
> > > closed
> > 
> > Please don't suspend my notebook when the lid is closed.
> 
> keep reading...
> 
> > > or when I press the suspend button
>     ~~
> 
> I.e. switch between those two modes according to how the laptop is
> being used at the time.  When travelling I use the lid switch to
> suspend (well I used to before I dropped it and broke the lid switch
> :) - at home I use the button.
> 
> I'd hope that suspend-to-disk could be activated in the same way
> (whatever way it is) that suspend-to-ram is now.
> 
> - Jamie
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

