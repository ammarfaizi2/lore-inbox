Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWBJMdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWBJMdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWBJMdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:33:04 -0500
Received: from ns.suse.de ([195.135.220.2]:31898 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751236AbWBJMdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:33:02 -0500
Date: Fri, 10 Feb 2006 13:32:59 +0100
From: Stefan Seyfried <seife@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060210123259.GB18577@suse.de>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210080643.GA14763@suse.de> <20060210121913.GA4974@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060210121913.GA4974@elf.ucw.cz>
X-Operating-System: SUSE LINUX 10.0.42 (i586) OSS Beta3, Kernel 2.6.16-rc2-git2-20060207172906-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 01:19:13PM +0100, Pavel Machek wrote:
> On Pá 10-02-06 09:06:43, Stefan Seyfried wrote:

> > Ok. Maybe i am not seeing the point. But why do we need this in the kernel?
> > Can't we handles this easily in userspace?
> 
> Some kernel parts need to now: for example powernow-k8: some

we can tell them from userspace.

> frequencies are not allowed when you are running off battery. [Just
> now it is solved by not allowing those frequencies at all unless ACPI
> is available; quite an ugly solution.]

And this is a reason to include it in the kernel?
Pavel? Is it you? What have they done to you? ;-)

I mean - we are moving suspend and everything to userspace, so i wonder
why this has to be in kernel.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
