Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUEKL0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUEKL0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 07:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUEKL0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 07:26:18 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:56519 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S262910AbUEKLZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 07:25:57 -0400
Message-ID: <40A0B7E4.7060103@keyaccess.nl>
Date: Tue, 11 May 2004 13:24:20 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
References: <409F4944.4090501@keyaccess.nl> <200405102125.51947.bzolnier@elka.pw.edu.pl> <409FF068.30902@keyaccess.nl> <200405102352.24091.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405102352.24091.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/mixed;
 boundary="------------020302020803050504060401"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302020803050504060401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bartlomiej Zolnierkiewicz wrote:

> Rene, can you send me copies of /proc/ide/hda/identify and
> /proc/ide/hdc/identify?

Sure, attached. Quite sure you wanted hdc though? That's a DVD-ROM.

> I still would like to know why these drives don't accept flush cache 
> commands (or it is a driver's bug?).

No idea I'm afraid. Seems at least new Maxtor drives are affected. Both
the "120P0" (120G, 8M cache) and "L0" (120G, 2M cache) were reported in
this thread.

> There is a problem with new 2.6 generic ->shutdown framework,
> it doesn't differentiate between reboot / halt and power_off.
> We may try to fix it or revert to 2.4 way of doing things if
> this is too big change for 2.6.

Please also see reply to Andrew...

Rene.


--------------020302020803050504060401
Content-Type: text/plain;
 name="hda"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hda"

# Maxtor 6Y120P0 (DiamondMax Plus 9, 120G, 8M cache)

0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 5933 3232 4144 4a45 2020 2020
2020 2020 2020 2020 0003 3e00 0039 5941
5234 3142 5730 4d61 7874 6f72 2036 5931
3230 5030 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 0fcf 0010
00ff f310 00fb 0108 f780 0e4f 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
00fe 001e 7c6b 7b09 4003 7c69 3a01 4003
107f 0000 0000 0000 fffe 600d c0c0 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0001 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 98a5


--------------020302020803050504060401
Content-Type: text/plain;
 name="hdc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdc"

# Plextor PX-116A DVD-ROM

85c0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 312e
3030 2020 2020 504c 4558 544f 5220 4456
442d 524f 4d20 5058 2d31 3136 4120 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0b00 0000 0400 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0000 0007
0003 0078 0078 00b4 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
003e 0000 4218 4000 4000 4218 0000 4000
101f 0000 0000 0000 0000 6000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000


--------------020302020803050504060401--
