Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTBULYY>; Fri, 21 Feb 2003 06:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbTBULYX>; Fri, 21 Feb 2003 06:24:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19210 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267383AbTBULYX>; Fri, 21 Feb 2003 06:24:23 -0500
Date: Fri, 21 Feb 2003 12:34:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       ak@suse.de, davem@redhat.com
Subject: Re: ioctl32 consolidation
Message-ID: <20030221113428.GF24049@atrey.karlin.mff.cuni.cz>
References: <20030220223119.GA18545@elf.ucw.cz> <20030220224433.GV9800@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220224433.GV9800@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > Currently, 32-bit emulation in kernel has *5* copies, and its >1000
> > lines each.
> 
> Yes :/  Consolidating all these copies into a single layer has been a
> "project to be" for quite some time.
> 
> I do not know if it is too late in 2.5.x to begin this work, however.
> We _are_ in a feature freeze...  I suppose it is up to the consensus of
> arch maintainers, because it [obviously] does not affect ia32.

Actually Andi asked me to do the work. Dave, is it okay with you? What
about other maintainers?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
