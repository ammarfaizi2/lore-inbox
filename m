Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267530AbSLEWQ5>; Thu, 5 Dec 2002 17:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267531AbSLEWQ5>; Thu, 5 Dec 2002 17:16:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26898 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267530AbSLEWQ4>; Thu, 5 Dec 2002 17:16:56 -0500
Date: Thu, 5 Dec 2002 23:24:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Eric Altendorf <EricAltendorf@orst.edu>, Jochen Hein <jochen@jochen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.grover@intel.com
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021205222431.GB7396@atrey.karlin.mff.cuni.cz>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212031007.01782.EricAltendorf@orst.edu> <87znrn3q92.fsf@gswi1164.jochen.org> <200212031247.07284.EricAltendorf@orst.edu> <20021205173145.GB731@elf.ucw.cz> <3DEFD17D.4090809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEFD17D.4090809@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Note that this link error occurs for me when swsusp is off, but 
> CONFIG_ACPI_SLEEP is on.
> 
> Disabling CONFIG_ACPI_SLEEP fixes the kernel build.

Yes, there are about 10 patches to fix it floating around... I just
hope linus takes one of them. (Fix is make ACPI_SLEEP depend on
swsusp).


								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
