Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130699AbRBILj1>; Fri, 9 Feb 2001 06:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130700AbRBILjR>; Fri, 9 Feb 2001 06:39:17 -0500
Received: from mgw-x3.nokia.com ([131.228.20.26]:55175 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S130699AbRBILjM>;
	Fri, 9 Feb 2001 06:39:12 -0500
Message-ID: <6D1A8E7871B9D211B3B00008C7490AA5645313@treis03nok>
From: Patrick.Stickler@nokia.com
To: snwahofm@mi.uni-erlangen.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel panics on C1VN and RH 6.2 or 7.0
Date: Fri, 9 Feb 2001 13:38:46 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
The serial capture approach is tough, as it has no serial
port, only USB, etc. (Sony calls it a "legacy free" machine,
and presumes that's a good thing ;-)

The second approach sounds more feasible. Forgive the
ignorant question: how do I lookup the faulting address in the
System.map file of my kernel -- especially since it probably
is in the RAM disk used for the installation, and hence
goes bye bye when the machine goes belly up?

Thanks,

Patrick

patrick.stickler@nokia.com

-----Original Message-----
From: ext Walter Hofmann
To: Patrick.Stickler@nokia.com
Sent: 2/9/01 1:31 PM
Subject: RE: Kernel panics on C1VN and RH 6.2 or 7.0



On Fri, 9 Feb 2001 Patrick.Stickler@nokia.com wrote:

>  
> I'll try, though since the system locks up in an unbootable
> state and most of the message scrolls off the screen and is
> unretrievable, it is difficult.

If you compile in the serial driver and activate the serial console, you
can then grab the oops with a second computer.

Alternatively you could just lookup the faulting address in the
System.map file of your kernel.

Walter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
