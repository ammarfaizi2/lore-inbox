Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268055AbTBRWEV>; Tue, 18 Feb 2003 17:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268042AbTBRWEV>; Tue, 18 Feb 2003 17:04:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268055AbTBRWEU>;
	Tue, 18 Feb 2003 17:04:20 -0500
Date: Tue, 18 Feb 2003 16:00:27 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: <torvalds@transmeta.com>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Fixes to suspend-to-RAM
In-Reply-To: <20030218220740.GD21974@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0302181556480.1035-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Bootmem needs to be reserved pretty soon in the boot process, that
> might be a problem.

That's not the issue. The call to the arch code would only check if the 
bootmem had been reserved, and as far the arch code knew, it was OK to 
enable S3. 


> Based on recent talk... Will you act as S3 maintainer so that I can
> submit patches to you and you'll take care of forwarding to Linus?

Yes, but please don't flood me with patches yet. I'm getting reacquainted 
with some of the more esoteric details of suspend states, and verifying 
that we have a working PM model for 2.6.

	-pat

