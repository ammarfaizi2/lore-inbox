Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131242AbRBLWBe>; Mon, 12 Feb 2001 17:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbRBLWBY>; Mon, 12 Feb 2001 17:01:24 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:7945 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S131242AbRBLWBU>; Mon, 12 Feb 2001 17:01:20 -0500
Date: Mon, 12 Feb 2001 19:01:58 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Julio Bianco <jbianco@hal.famaf.unc.edu.ar>
Subject: problem with modules in 2.2.14
Message-ID: <20010212190158.A2816@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Julio Bianco <jbianco@hal.famaf.unc.edu.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all.

We've written a module for kernel 2.2.14 that includes a driver
for 2 "virtual" devices. These devices don't actually exist,
they're implemented with two circular buffers; what's written
into one of the devices is read from the other, and viceversa.

We believe the buffer is correctly written, but we have the
following problem: We can insmod, read, write, and rmmod, and
everything's OK. However, as soon as we logout we get 'INIT: Id
"n" respawning too fast: disabled for 5 minutes.', where "n" is
each of the consoles we were logged in at (5 minutes later, the
same message occurrs).

We have no idea what it could be, any pointers?

        Julio Bianco
	Edgardo Hames
	FaMAF - UNC
	

[ forwarded w/translation by me ]
		
-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
Somewhere, just out of sight, the unicorns are gathering.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
