Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRGVVq2>; Sun, 22 Jul 2001 17:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268072AbRGVVqS>; Sun, 22 Jul 2001 17:46:18 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:25500 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S268071AbRGVVqB>;
	Sun, 22 Jul 2001 17:46:01 -0400
Message-ID: <3B5B499B.97D5AC27@candelatech.com>
Date: Sun, 22 Jul 2001 14:46:03 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [BUG REPORT]  Sony VAIO, 2.4.7:  CardBus failures with Tulip & 3c575 
 cards.
In-Reply-To: <3B5B1F77.D8B45FFA@candelatech.com> <3B5B36D5.3F08C0BC@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------3AA1E8B51170AF9DA1924108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------3AA1E8B51170AF9DA1924108
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> 
> > Chapter 1, AmbiCom in slot 1 hangs the sytem untill removed.
> 
> I get this too with a test 8139 that RealTek sent me.  The behavior
> occurs on a Compaq K6-2 laptop and also a Toshiba P-III laptop.  I
> assumed it was a bad card sent from the bowels of RealTek engineering,
> but maybe not...
> 
> Changing "#if 0" to "#if 1" at the top of yenta.c, and logging the
> output (perhaps with minicom, over a serial console) would probably be
> interesting...

(I did an su to get something into the logs to mark a starting point.)

Here, I insert the tulip into slot 1.  It continiously prints this stuff
out, and from the fuzzy pattern wizzing by the console, it appears that
it will just print out the same pattern as long as I have the card inserted.

I did remove the NIC, and though I cannot be certain, I believe that log
starts exactly where this pattern stops.  It does print out a bunch more
stuff before settling down...

After that, the debug spew continues every second or so.

If you'd like to see something else, plz let me know now to get
it to boot up in serial-console mode (and change run-level to 3 instead of
5 as I have it set now...)


>         Jeff, who swears he's still on vacation :)

Heh, I came back from vacation to find this lying in wait for me! :)

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
--------------3AA1E8B51170AF9DA1924108
Content-Type: application/x-gzip;
 name="tulip_yenta.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="tulip_yenta.txt.gz"

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
--------------3AA1E8B51170AF9DA1924108--

