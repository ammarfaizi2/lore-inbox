Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280586AbRK1UFJ>; Wed, 28 Nov 2001 15:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280600AbRK1UFE>; Wed, 28 Nov 2001 15:05:04 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:30709 "EHLO
	phobos.mvista.com") by vger.kernel.org with ESMTP
	id <S280586AbRK1UEl>; Wed, 28 Nov 2001 15:04:41 -0500
Message-ID: <3C0542F3.5A9F0EAA@mvista.com>
Date: Wed, 28 Nov 2001 12:02:59 -0800
From: Jeremy Puhlman <jpuhlman@mvista.com>
Organization: MontaVista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Google Test and 2.4.16
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok yesterday got the google tests running...The machine I ran it on
was a standard (Old) white box...Athlon k6-450 with 128 MB of
Ram....Using 256 MB of swap....The google test tries to use an
adjustable 1/2 terra byte Block size...This is unrealistic for an
embedded system or my system for that matter..So in trying to tune the
test to the system it seems they would not run unless the block size
was less then 60 MB...Not sure what the deal was...I tried turning on
memory-overcommit but no dice...

So basically I ran the test once through and every thing went fine...The

test didn't seem to really stress the system very much...

So I ran the same program 4 times, concurrently...The system did not
seem to lose any responsiveness....This did stress the vm system since
each of the processes were grabbing 60 megs...

I did find that once the 4 processes finished their runs. I ran one
more just for fun...Then the system locked up...

Jeremy

