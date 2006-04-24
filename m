Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWDXUU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWDXUU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWDXUU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:20:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37770 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751224AbWDXUUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:20:50 -0400
Date: Mon, 24 Apr 2006 22:20:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: dtor_core@ameritech.net, Matthew Garrett <mjg59@srcf.ucam.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060424202006.GD3386@elf.ucw.cz>
References: <20060419195356.GA24122@srcf.ucam.org> <20060419200447.GA2459@isilmar.linta.de> <20060419202421.GA24318@srcf.ucam.org> <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com> <1145894731.7155.120.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145894731.7155.120.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Whilst sort of on the subject (AC power switches and AC power events)
> I'd like to see some standard way of exporting power/battery information
> to userspace. Currently, the ARM handhelds use kernel emulation of an
> APM bios and export the battery info as part of that. Making ARM emulate
> ACPI interfaces doesn't appeal. The answer could be a battery sysfs
> class and the above system events interface but I'm open to other
> suggestions.

Battery sysfs class would be _very_ welcome. Both existing interfaces
(APM and ACPI) are crap :-(.
								Pavel
-- 
Thanks for all the (sleeping) penguins.
