Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWIJU6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWIJU6U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWIJU6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:58:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63120 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964932AbWIJU6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:58:19 -0400
Date: Sun, 10 Sep 2006 22:58:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: io-apic breaks suspend unless acpi_skip_timer_override
Message-ID: <20060910205803.GA1966@elf.ucw.cz>
References: <20060910141533.GA6594@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910141533.GA6594@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-09-10 15:15:34, Matthew Garrett wrote:
> ACPI suspend/resume fails on my HP nx6125 unless I either:
> 
> a) boot with noapic, or
> b) boot with acpi_skip_timer_override
> 
> Does anyone have the faintest idea how to debug this?

Do you mean suspend-to-RAM? Can you try beeping patch?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
