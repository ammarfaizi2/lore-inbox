Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270840AbTGNV1I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270758AbTGNT7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:59:01 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:57827 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S270777AbTGNT6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:58:14 -0400
Date: Mon, 14 Jul 2003 22:12:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030714201245.GC24964@ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030713193114.GD570@elf.ucw.cz> <1058130071.1829.2.camel@laptop-linux> <20030713210934.GK570@elf.ucw.cz> <1058147684.2400.9.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058147684.2400.9.camel@laptop-linux>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 01:54:44PM +1200, Nigel Cunningham wrote:

> Having listened to the arguments, I'll make pressing Escape to cancel
> the suspend a feature which defaults to being disabled and can be
> enabled via a proc entry in 2.4. I won't add code to poll for ACPI (or
> APM) events :>

I'd suggest making it a mappable function in the keymap, like reboot is
for example. Both for initiating and stopping the suspend. How about
that?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
