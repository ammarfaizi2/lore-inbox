Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLPB1I>; Fri, 15 Dec 2000 20:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQLPB0s>; Fri, 15 Dec 2000 20:26:48 -0500
Received: from ubr-33.77.219.titusville.cfl.rr.com ([65.33.77.219]:24339 "EHLO
	gumby.chiodini.net") by vger.kernel.org with ESMTP
	id <S129289AbQLPB0o>; Fri, 15 Dec 2000 20:26:44 -0500
Message-ID: <3A3ABC0B.49D0FE78@cfl.rr.com>
Date: Fri, 15 Dec 2000 19:49:15 -0500
From: Bob Chiodini <rchiodini@cfl.rr.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Harley Anderson <q9202867@quoin.cqu.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: IRQ problem? (oops in test12)
In-Reply-To: <00121521194500.17367@satan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harley Anderson wrote:

> Howdy again folks, I have another oops for ya's to look over...
>
> Yesterday when I was about to patch and build the new (test12) kernel I found
> the ominous message:
> Kernel panic: attempted to kill init!
> Something like that anyway. No other info, just locked up solid.
> No real clues on that one sorry.

I had this problem too, at boot up.  I too have a REALTEK 8139 controller and it shares the interrupt with the USB, which I am not
using.  The oops was consistent everytime I tried to boot, so I couldn't really capture it.  I configured USB support as a module, voila
the system boots fine and has up for 48 hours.  I have no USB devices, just built the modules since there seems to be changes in that
area.  I have not tried backing out the USB support, and testing again.

I built test12 from source, no patches.  I had no problems with any of the pre releases for test12.

--

rchiodini@cfl.rr.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
