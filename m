Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278358AbRJSLOb>; Fri, 19 Oct 2001 07:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278359AbRJSLOW>; Fri, 19 Oct 2001 07:14:22 -0400
Received: from web10401.mail.yahoo.com ([216.136.130.93]:49423 "HELO
	web10401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278358AbRJSLOH>; Fri, 19 Oct 2001 07:14:07 -0400
Message-ID: <20011019111440.5768.qmail@web10401.mail.yahoo.com>
Date: Fri, 19 Oct 2001 21:14:40 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: feedback for the new Rik VM patch 2.4.12-ac3
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Although some users are quite happy with that patch
but not me :-)

- I use 2.4.12-ac2 + Robert preempt patch on i686
400Mh, 128Mb ram 72 , yes only 72Mb swap and run
roughly:

Star Office 5.2 with one 10Kb html document open
Mozilla 0.9.2 browsing web
gnomeicu
Limewire
gimp and open a 1.7Mb tif (using Jpeg compression)
image
Compiling the kernel 2.4.12-ac3 with the Rik VM patch
two rxvt, one is for running the compilation ; one for
checking with free,

When I start Limewire (the last app I start), swap
usage is nearly 0, I thought the OOM would kill some
app. but it did not, and Limwwire starts ok, check
swap still about 500Kb free. 

Then I so all the same for the newly made kernel, 

The result is I got more swap ; after all for the
second kernel, free swap is still 10Mb; But in the
trade off performance!. It is sluggish to switch
bettween windows (than the last kernel) and the disk
is thrashing when I exit Star Office and gimp too hard
so that it made the system scrawling, but it is fairly
good in the last kernel.

I usr pgcc 2.95.2.1 to compile both kernel and use -O6
for optimization.

Does anyone see the same?










=====
S.KIEU

http://briefcase.yahoo.com.au - Yahoo! Briefcase
- Manage your files online.
