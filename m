Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWBRMzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWBRMzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWBRMzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37787 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751213AbWBRMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:07 -0500
Date: Thu, 16 Feb 2006 23:39:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Renninger <trenn@suse.de>, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060216223945.GK3490@openzaurus.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de> <200602142117.31232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602142117.31232.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > AMD64 laptops are booting with lower freqs per default until they are
> > pushed up, so there shouldn't be anything critical?
> 
> This is not true as far as my box is concerned (Asus L5D).  It starts with
> the _highest_ clock available.

Not all laptops have underpowered batteries. And I have
seen machine that booted fast with underpowered battery...
not nice. Would crash in POST in 30% cases.
> 
> > For the brightness part, I don't see any "laptop is going to explode"
> > issue.
> > I always hated the brightness going down when I unplugged ac on M_
> 
> Currently I have the same problem on Linux, but I don't know the solution
> (yet).  Any hints? :-)

Work around acpi bios... not going to be nice.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

