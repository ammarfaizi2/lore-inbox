Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270606AbTGNNHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTGNNAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:00:52 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:53218 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270679AbTGNM6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:58:44 -0400
Date: Mon, 14 Jul 2003 15:11:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030714131132.GD221@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030713193114.GD570@elf.ucw.cz> <1058130071.1829.2.camel@laptop-linux> <20030713210934.GK570@elf.ucw.cz> <1058147684.2400.9.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058147684.2400.9.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Having listened to the arguments, I'll make pressing Escape to cancel
> the suspend a feature which defaults to being disabled and can be
> enabled via a proc entry in 2.4. I won't add code to poll for ACPI (or
> APM) events :>

At least no new proc entry, please. Make it depend on sysrq_enabled
and disable it completely if sysrq support is not compiled in.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
