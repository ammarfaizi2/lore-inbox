Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbRAKDYx>; Wed, 10 Jan 2001 22:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131692AbRAKDYn>; Wed, 10 Jan 2001 22:24:43 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:38162 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S129777AbRAKDYh>;
	Wed, 10 Jan 2001 22:24:37 -0500
Date: Wed, 10 Jan 2001 20:22:24 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: jayts@bigfoot.com
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010110202224.C4624@hq.fsmlabs.com>
In-Reply-To: <3A57DA3E.6AB70887@uow.edu.au> <200101110312.UAA06343@toltec.metran.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200101110312.UAA06343@toltec.metran.cx>; from Jay Ts on Wed, Jan 10, 2001 at 08:12:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} > - If you care about latency, be *very* cautious about upgrading to
} >   XFree86 4.x.  I'll cover this issue in a separate email, copied
} >   to the XFree team.
} 
} Did that email pass by me unnoticed?  What's the prob with XF86 4.0?

The darn thing disables intrs on its own for quite some time with some of
the more aggressive drivers.  We saw our 20us latencies under RTLinux go up
a lot with some of those drivers.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
