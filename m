Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSLOTKs>; Sun, 15 Dec 2002 14:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSLOTKs>; Sun, 15 Dec 2002 14:10:48 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:4240 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262384AbSLOTKr>;
	Sun, 15 Dec 2002 14:10:47 -0500
Date: Sun, 15 Dec 2002 19:17:48 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Scott Robert Ladd <scott@coyotegulch.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel for Pentium 4 hyperthreading?
Message-ID: <20021215191748.GA24207@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Scott Robert Ladd <scott@coyotegulch.com>,
	linux-kernel@vger.kernel.org
References: <20021215155728.GB20335@suse.de> <FKEAJLBKJCGBDJJIPJLJGEIHDLAA.scott@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FKEAJLBKJCGBDJJIPJLJGEIHDLAA.scott@coyotegulch.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 12:40:59PM -0500, Scott Robert Ladd wrote:
 > Dave Jones wrote:
 > > Ah, apologies. Yes. In this case, you win. I bit the same problem you
 > > had btw with this box in 2.4. You need an updated BIOS. Contact Intel.
 > 
 > I'll ask Intel if there's a BIOS update. Computers are almost as bad as
 > games now; the first thing you need to do before using them is patch!
 > 
 > What evokes my curiosity is that the 2.5.51 kernel detects and correctly
 > uses the processor siblings, while 2.4.20 does not. Given that 2.5.51 is
 > running quite well, I think I'll just stay on the bleeding edge of Linux for
 > a while.

I think the problem was a missing MP table in the factory-shipped BIOS.
2.5 used ACPI to enumerate the siblings, whereas the 2.4 ACPI is a
little out of date in that department.
At least that was my random guess when I hit that problem.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
