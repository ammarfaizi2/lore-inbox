Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSJDHbx>; Fri, 4 Oct 2002 03:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261525AbSJDHbw>; Fri, 4 Oct 2002 03:31:52 -0400
Received: from 62-190-218-239.pdu.pipex.net ([62.190.218.239]:261 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261524AbSJDHbv>; Fri, 4 Oct 2002 03:31:51 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210040744.g947igQr000698@darkstar.example.net>
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice)
To: davej@codemonkey.org.uk (Dave Jones)
Date: Fri, 4 Oct 2002 08:44:42 +0100 (BST)
Cc: akpm@digeo.com, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021003220553.GA13540@suse.de> from "Dave Jones" at Oct 03, 2002 11:05:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Yet John Bradford says that in swapless 8MB, 2.5.40 is "springier"
>  > than 2.4.x, so weird.
> 
> Depends on what tests are I suppose. "springier" doesn't
> really say too much. We do minimise memory usage in a few
> places if mem<16M though iirc which could be helping this case.

Well, I've got the following:

486, SX-25 laptop, with 8 MB Ram, no swap, running 2.5.40 and also 2.4.19.
486, SX-20 laptop, with 4 MB Ram, 20 MB swap, running 2.2.21, and 2.2.13.

Both are capable of running the lastest Apache, with PHP support, and Lynx at a usable speed, (I use the 8 MB Ram machine for debugging small bits of PHP while I'm on the tube going up to London :-) ).

I know "feels springier" isn't very helpful, but what benchmarks do you expect me to run on machines with 120 Meg HDs?  :-)  Suggest something, and I'll give it a go.  It's not really faster, just more responsive, (E.G. doing a updatedb, and using jed at the same time is better in 2.5.x).

By the way, I've got X11 running on the 4 meg one, and it's quite usable.  I have even demoed a graphical browser accessing the local Apache, serving PHP content.

If anybody doesn't believe me, come along to Linux Expo UK next week, and see for yourselves :-).

John.
