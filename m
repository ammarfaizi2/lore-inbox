Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSKOBO0>; Thu, 14 Nov 2002 20:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSKOBO0>; Thu, 14 Nov 2002 20:14:26 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:3590 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S265424AbSKOBO0>;
	Thu, 14 Nov 2002 20:14:26 -0500
Date: Fri, 15 Nov 2002 01:21:11 +0000
From: John Levon <levon@movementarian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       rl@hellgate.ch, linux-kernel@vger.kernel.org,
       Mikael Pettersson <mikpe@csd.uu.se>, mingo@redhat.com
Subject: Re: Yet another IO-APIC problem (was Re: via-rhine weirdness with viakt8235 Southbridge)
Message-ID: <20021115012111.GB15619@compsoc.man.ac.uk>
References: <20021115002822.G6981@pc9391.uni-regensburg.de> <20021115011738.D17058@pc9391.uni-regensburg.de> <3DD445EF.9080002@pobox.com> <3DD4481F.72627800@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD4481F.72627800@digeo.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18CVAX-000Osn-00*hj7jsyLVXDE* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 05:04:31PM -0800, Andrew Morton wrote:

> It would be nice to get it working, because oprofile needs it.

That's the local APIC (CONFIG_X86_UP_APIC) not IO-APIC
(CONFIG_X86_UP_IOAPIC). They should be separate, and it's been a while
since I've tested it, but CONFIG_X86_UP_IOAPIC=n should still work OK

regards
john
-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
