Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276468AbRJ2QxC>; Mon, 29 Oct 2001 11:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRJ2Qww>; Mon, 29 Oct 2001 11:52:52 -0500
Received: from adsl-63-207-97-74.dsl.snfc21.pacbell.net ([63.207.97.74]:56307
	"EHLO nova.botz.org") by vger.kernel.org with ESMTP
	id <S276468AbRJ2Qwo> convert rfc822-to-8bit; Mon, 29 Oct 2001 11:52:44 -0500
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: eepro100.c & Intel integrated MBs
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 29 Oct 2001 08:53:15 -0800
Message-ID: <11361.1004374395@nova.botz.org>
From: Jurgen Botz <jurgen@botz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently discovered (as others have posted to the list) that the
currently included eepro100 driver doesn't work on Intel 815 (and
possibly other) integrated mainboards.  I stops working after a bit
of activity and in some circumstances totally locks up the machine.
For more details scan the archives, lots of people have run into
this.

I'm now using the e100 driver from the Intel web site, which works
perfectly, and light testing shows the Scyld (Don Becker) driver
to work as well.  The Intel driver seems to have an incompatible
license (noxious advertising clause?), but the Scyld drivers don't...
at least there isn't any license mentioned and of course many 
of the net drivers in the current kernel are just earlier versions
of the Scyld drivers.

815 MBs are pretty common, so getting a solution to this should
be pretty important.  I'm surprised that RedHat didn't include
the Scyld drivers in 7.2... these network lockups should present
a major support headache for them.

So what's the scoop?  Anyone have plans to fix this?

:j

-- 
Jürgen Botz                       | While differing widely in the various
jurgen@botz.org                   | little bits we know, in our infinite
                                  | ignorance we are all equal. -Karl Popper


