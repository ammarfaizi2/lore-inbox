Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317567AbSGTW0A>; Sat, 20 Jul 2002 18:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317568AbSGTW0A>; Sat, 20 Jul 2002 18:26:00 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:7139 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S317567AbSGTW0A>;
	Sat, 20 Jul 2002 18:26:00 -0400
Date: Sun, 21 Jul 2002 00:29:05 +0200
From: bert hubert <ahu@ds9a.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: keyboard ONLY functions in 2.5.27 with local APIC on for UP
Message-ID: <20020720222905.GA15288@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech, list,

I find that my keyboard only works if I turn on the local APIC on UP on my
laptop. The only clue I see scrolling past is something about 'AT keyboard
timeout, not present?'. I don't have my nullmodem cable handy to check it
out further.

I do see it talking about interrupt 1 and IO 0x60. I've also compiled it
with the SERIO debugging setting and ATKBD debugging on, but I still don't
see anything useful.

Every once in a while it would say 'unknown scancode from keybord set 0,
0x2' and then some more numbers. I feel bad that I can't be anymore specific
right now.

If you want me to do some more checking, let me know, and I'll hook up the
serial.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
