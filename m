Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132652AbRDLCrE>; Wed, 11 Apr 2001 22:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133043AbRDLCqz>; Wed, 11 Apr 2001 22:46:55 -0400
Received: from altus.drgw.net ([209.234.73.40]:526 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S132652AbRDLCqp>;
	Wed, 11 Apr 2001 22:46:45 -0400
Date: Wed, 11 Apr 2001 21:32:36 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Torrey Hoffman <torrey.hoffman@myrio.com>, linux-kernel@vger.kernel.org
Subject: Re: natsemi.c (Netgear FA311 card) probmlems??
Message-ID: <20010411213236.P13920@altus.drgw.net>
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B59@mail0.myrio.com> <3AC22661.E69BE205@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <3AC22661.E69BE205@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Mar 28, 2001 at 12:58:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 12:58:57PM -0500, Jeff Garzik wrote:
> There are some improvements in the latest 2.4 test patch, 2.4.3-pre8.  I
> would be very interested in hearing feedback on that.  I finally got two
> test cards, FA311 and FA312, so I can work on it a bit too.

Okay, I finally got around to testing this on 2.4.4-pre1. for the 5 or so 
minutes I've been using it so far, it seems okay (I'm able to log in this 
time), and I'm running NetPIPE to check performance.

Perfomance isn't great (the peak bandwidth is 65 Mbps or so), but this
could be partially due to my switch or the other machine I'm testing it
with.

> 
> The 2.4.3-pre8 patch, against kernel 2.4.2, is available from
> ftp://ftp.us.kernel.org/pub/linux/kernel/testing/
> 
> This updated 2.4 natsemi.c merges the changes in Becker's latest, which
> should fix eeprom/mac address reading as you mention, and it also
> includes some power management fixes required on some boards. 
> Differences from 2.2 versions include locking updates and some other
> small differences.  Please test, if you have an opportunity.
> 
> (note you'll have to fix a screwup of mine in drivers/net/Makefile --
> you need to add net_init.o to export-objs before you can build net
> drivers as modules.  Building them into the kernel works fine.)
> 
> -- 
> Jeff Garzik       | May you have warm words on a cold evening,
> Building 1024     | a full moon on a dark night,
> MandrakeSoft      | and a smooth road all the way to your door.
> 

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
