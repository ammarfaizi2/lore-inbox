Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131162AbQLHOob>; Fri, 8 Dec 2000 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131589AbQLHOoL>; Fri, 8 Dec 2000 09:44:11 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:51465 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S131162AbQLHOoA>; Fri, 8 Dec 2000 09:44:00 -0500
Message-ID: <3A30EC28.1090203@megapathdsl.net>
Date: Fri, 08 Dec 2000 06:11:52 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001206
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Bernd Kischnick <kisch@mindless.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: patch: test12-pre7 cd stuff
In-Reply-To: <20001207195539.P6832@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

I have tested your latest stuff (cd-2) with the CD that was
causing problems before.  The problems still occur.
The CD plays fine, but I get the following errors in
my /var/log/messages:

Dec  8 06:05:29 agate kernel: hdc: packet command error: status=0x51 { 
DriveReady SeekComplete Error }
Dec  8 06:05:29 agate kernel: hdc: packet command error: error=0x50
Dec  8 06:05:29 agate kernel: ATAPI device hdc:
Dec  8 06:05:29 agate kernel:   Error: Illegal request -- (Sense key=0x05)
Dec  8 06:05:29 agate kernel:   Invalid field in command packet -- 
(asc=0x24, ascq=0x00)
Dec  8 06:05:29 agate kernel:   The failed "Play Audio MSF" packet 
command was:
Dec  8 06:05:29 agate kernel:   "47 00 00 00 02 00 3f 24 ff 00 00 00 "
Dec  8 06:05:29 agate kernel:   Error in command packet byte 8 bit 0
Dec  8 06:05:29 agate kernel: Play from track 1 to 9
Dec  8 06:05:29 agate kernel: lba 0 to lba 286050

Here's a pointer to the CD that is causing trouble.  Perhaps
you could buy a copy and sort this out.  It's a great CD!

http://www.amazon.com/exec/obidos/ASIN/B00000DDPZ

Thanks,
	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
