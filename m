Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTAUKic>; Tue, 21 Jan 2003 05:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbTAUKic>; Tue, 21 Jan 2003 05:38:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28684 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266453AbTAUKic>; Tue, 21 Jan 2003 05:38:32 -0500
Date: Tue, 21 Jan 2003 11:47:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Ask devices to powerdown before S3 sleep
Message-ID: <20030121104737.GC24349@atrey.karlin.mff.cuni.cz>
References: <20030119214642.GA27885@elf.ucw.cz> <Pine.LNX.4.10.10301201714120.16070-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10301201714120.16070-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Could you do me just one tiny favor?
> Please consider attempting an error recovery level path, maybe ...
> 
> Every patch I have glanced at has 'panic("blah blah");'
> 
> If you do not have enough hardware to generate an accurate path for
> recovery, then please do not force the kernel into panic.  Would you
> consider failing the request making it jump back to S1 ?  This at least
> allows it crash like a power failure.

If I make it go S1, auto-reboot will not apply etc, and machine will
crash during ENABLE, anyway...
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
