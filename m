Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVLFBrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVLFBrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVLFBrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:47:23 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:13989 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S964906AbVLFBrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:47:23 -0500
Date: Mon, 5 Dec 2005 17:47:20 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206014720.GN22168@hexapodia.org>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133831242.6360.15.camel@localhost> <20051206013759.GI1770@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206013759.GI1770@elf.ucw.cz>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 02:37:59AM +0100, Pavel Machek wrote:
> > desktop here at work, for example, writes the image at 72MB/s and reads
> > it back at 116MB/s. (3GHz P4 with a Maxtor 6Y120L0). Writing 1GB at
> > these rates is not a problem.

Hmm, I only wish...

> Andy reported 20MB/sec on hdparm. I do not think it is possible to
> write faster than that. And that seems about ok for notebooks, X32
> (pretty new) has:
> 
> root@amd:~# hdparm -t /dev/hda

You named your X32 "amd"?  How ... confusing ... (assuming it, like all
other Thinkpad X series I know, has a Pentium M.)

> /dev/hda:
>  Timing buffered disk reads:  108 MB in  3.01 seconds =  35.85 MB/sec

That's quite a bit better than mine, and I am pretty sure I am the same
vintage or newer (purchased this summer), but I'm getting barely half
that speed:
 Timing buffered disk reads:   58 MB in  3.10 seconds =  18.70 MB/sec

How can I find out what disk is in this beast and try to track down some
of my missing performance?  It looks like I have the right DMA settings
and whatnot looking at hdparm(1).

-andy
