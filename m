Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbRBBUEr>; Fri, 2 Feb 2001 15:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRBBUEh>; Fri, 2 Feb 2001 15:04:37 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15341 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S129996AbRBBUEX>; Fri, 2 Feb 2001 15:04:23 -0500
Message-ID: <3A7B1129.2ED4CCE4@dmi.usherb.ca>
Date: Fri, 02 Feb 2001 14:57:29 -0500
From: Delta <birtl00@dmi.usherb.ca>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System unresponsitive when copying HD/HD
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id HAA26707

Hi,

I backup my linux partition once a month from my second IDE drive to an
empty partition
on the first IDE disk. I have about 2.8 Gig to copy, and I use <cp -ax /
/mnt/hd> to do the copy.

While cp is copying from the second hard disk to the first hard disk,
I find my system performance
drop VERY sharply.  X is sloppy, even bash takes many seconds to
respond.  I using two
recent IDE disk (Fudjisu 13 gig, Maxtor 20 Gig), so I'm wondering why
the system is so slow?  My mobo is a FIC SD11 and I have an athlon
550 Mhz.

I tried renicing the process priority to 20, but I don't see any
improvement on system usability.
Hard disk activity is still frenzy, even if there are other task
runnable (X, g++ jobs).
Note that I'm running as root when I'm doing the copy.

So I'd like to know why the linux kernel can't schedule the task less
often?
I guess that copying file doesn't eat too many CPU cycles, but is
running almost all the time
in kernel mode doing I/O... Is there a way to prevent a process from
"hogging" the hard disk like that?
It's pretty annoying when the system is sluggish like that.

Thanks a lot,
Laurent Birtz <birtl00@dmi.usherb.ca>

If you wish to reply, I'm not on the list so reply directly to me..
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€ù^jÇ«y§m…á@A«a¶Úÿÿü0ÃûnÇú+ƒùd
