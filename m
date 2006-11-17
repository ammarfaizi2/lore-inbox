Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424564AbWKQPQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424564AbWKQPQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162420AbWKQPQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:16:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45292 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S933662AbWKQPQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:16:15 -0500
Date: Fri, 17 Nov 2006 16:15:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061117151559.GC8859@elf.ucw.cz>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061107204409.GA37488@vasa.acc.umu.se> <20061107134439.1d54dc66.kristen.c.accardi@intel.com> <20061117102237.GS14886@vasa.acc.umu.se> <20061117151341.GA1162@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117151341.GA1162@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-11-17 15:13:41, Matthew Garrett wrote:
> On Fri, Nov 17, 2006 at 11:22:38AM +0100, David Weinehall wrote:
> 
> > That was with 2.6.17; with 2.7.19-pre? (don't remember right now),
> > docking seems to work without acpiphp.  It still would be nice to be
> > able to undock when the laptop is sleeping though; how do I achieve
> > that?
> 
> My experience of most laptops is that they'll fire off a bus check 
> notification when you resume, so as long as nothing actually tries to 
> access the hardware before that's handled, everything should be fine. 
> What currently breaks when you undock while asleep?

(At least some versions of dock can't undock -- physically -- when not
powered. Something is locked inside, and won't unlock without electricity).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
