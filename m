Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272373AbTHECWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272375AbTHECWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:22:49 -0400
Received: from web60006.mail.yahoo.com ([216.109.116.229]:25770 "HELO
	web60006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272373AbTHECWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:22:05 -0400
Message-ID: <20030805022205.60269.qmail@web60006.mail.yahoo.com>
Date: Tue, 5 Aug 2003 03:22:05 +0100 (BST)
From: =?iso-8859-1?q?Steven=20Newbury?= <s_j_newbury@yahoo.co.uk>
Subject: Re: linux-2.6.0-test2-mm2 with BadRAM patch
To: Harold Wheaton <hew@gate.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1059880326.3119.35.camel@paradise>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Harold Wheaton <hew@gate.net> wrote: > Hello Steven.  My name is Harold
and I happened to get your recent
> BadRAM patch running on the linux-2.6.0-test2-mm2 kernel.
> 
> I just upgraded to 2.6 today, and since I do have a minor memory
> problem, I needed to get BadRAM going.  Fortunately I found your post
> with the compressed patch (which that one is indeed not corrupt) and got
> it in there without any difficulty.  It's coming up with the
> announcement about "4k BadRAM".
> 
> So far the kernel is rock solid and I've tested games and multimedia,
> but I'm not really sure if I'm a great test case.  I have 1 gig of RAM
> with one intermittently bad bit at around the 250 meg spot, making it
> tough to gauge the patch's effectiveness.  Also, I am not running
> HighMem as I've read that it may expose a dormant bug on these newer
> kernels.
A bug in BadRAM or the kernel proper?  There was/is a bug in the original
BadRAM patch with HighMem though it should be fixed in my patch.  It might be
worth you trying it.

> 
> I hope this helps in case you are still concerned about the patch. 
> Thank you for getting it to kernel version 2.6 and I think we all hope
> that it can make it in the official baseline at some point so that
> regular users will be able to take advantage of it.
> -Harold
> 
>  

Yes, it does seem to be okay.  I had unfortunatly made my system unstable by
tweaking the chipset PCI configuration space.  The tweaking was stable on 2.4.x
so I had assumed it wasn't the problem... it was!  2.6 seems to put more stress
on the system (probably due to CPU optimized memcopy's or something similar).

Thankyou for the feedback.


=====
Steve

__________________________________________________
Yahoo! Plus - For a better Internet experience
http://uk.promotions.yahoo.com/yplus/yoffer.html
