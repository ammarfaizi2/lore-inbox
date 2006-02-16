Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWBRMzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWBRMzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWBRMzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38299 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751235AbWBRMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:07 -0500
Date: Thu, 16 Feb 2006 23:44:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060216224439.GL3490@openzaurus.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de> <200602142117.31232.rjw@sisk.pl> <43F3206B.6090902@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F3206B.6090902@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >This is not true as far as my box is concerned 
> >(Asus L5D).  It starts with
> >the _highest_ clock available.
> Hmm, but then there shouldn't be any critical 
> overheat problems and if,
> the hardware has to switch off the machine 
> hard. OS always could freeze,
> but the battery must not start to burn...

I told that to hw designers... too late. Fortunately batteries usually
only crash machine if you overload them.

> IMO, the /sys/.../brightness patch should go in 
> as soon as possible, I think
> all everybody agrees here?

Yep.

> Maybe I oversaw an issue, but I really don't 
> see a reason for connecting
> the brightness to ac in kernel space.

We are not going to connect it. But to implement .../brightness, you need to
know ac/battery on several "broken" notebooks.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

