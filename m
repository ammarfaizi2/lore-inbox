Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbQKPWMb>; Thu, 16 Nov 2000 17:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129957AbQKPWMV>; Thu, 16 Nov 2000 17:12:21 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:59148 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129771AbQKPWMN>;
	Thu, 16 Nov 2000 17:12:13 -0500
Date: Thu, 16 Nov 2000 13:42:58 -0800
From: David Hinds <dhinds@valinux.com>
To: tytso@valinux.com
Cc: pavel@suse.cz, jgarzik@mandrakesoft.com, dwmw2@infradead.org,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, tutso@mit.edu
Subject: Re: [PATCH] pcmcia event thread. (fwd)
Message-ID: <20001116134258.B5707@valinux.com>
In-Reply-To: <Pine.LNX.4.30.0011132222070.28525-100000@imladris.demon.co.uk> <3A106F81.FB5BE7F1@mandrakesoft.com> <20000101025452.A53@toy> <E13wWYG-00047b-00@beefcake.hdqt.valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <E13wWYG-00047b-00@beefcake.hdqt.valinux.com>; from tytso@valinux.com on Thu, Nov 16, 2000 at 01:26:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 01:26:36PM -0800, tytso@valinux.com wrote:
> 
> > Ted, is this true? It would be wonderfull to be able to use i82365 without
> > need for pcmcia_cs...
> 
> > I think in-kernel pcmcia crashing even on simple things *is* critical bug.

It wasn't a critical bug, in the sense that because the i82365 driver
did not work, it was not even offered as a config option.  If anything
it was merely a missing feature.  And not a critical one, since the
feature was available outside of the kernel.

It is a moot point, since i82365 works with the new patches.

> That was several months ago, and perhaps things have changed.  But that
> was I didn't spend time worrying about tracking PCMCIA bug reports;
> there were a non-trivial number of them, and they were mostly of the
> form "doesn't work on XXX hardware", "causes kernel oops on YYYY
> hardware", etc.

Some of these have been resolved, but some remain.  They have not been
easy things to decipher since they involve interactions between the
PCI subsystem, PCMCIA, and specific hardware.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
