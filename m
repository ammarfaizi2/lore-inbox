Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSE1VLT>; Tue, 28 May 2002 17:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316934AbSE1VLS>; Tue, 28 May 2002 17:11:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54024 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316964AbSE1VLR>; Tue, 28 May 2002 17:11:17 -0400
Date: Tue, 28 May 2002 23:11:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020528211120.GA28189@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <20020527194018.GQ14918@holomorphy.com> <20020528193220.GB189@elf.ucw.cz> <20020528210917.GU14918@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I had to add
> > 	if (!curr) break; 
> > to fix the oops. It now looks way nicer. Thanx.
> 
> It's pretty odd that this happens to the buddy lists. I guess if it's
> needed as a stopgap measure, I can't complain too much, but I'd suspect
> something's corrupting it or you're catching a buddy list operation in
> progress. I might be interested in taking a stab at finding out where
> the corruption happens if you also think that's what's going on.

I think it is not a coruption, but something like

"not all list are valid on non-himem machine", or something like that.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
