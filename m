Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262855AbRE0SYi>; Sun, 27 May 2001 14:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262856AbRE0SY2>; Sun, 27 May 2001 14:24:28 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:23281 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S262855AbRE0SYM>;
	Sun, 27 May 2001 14:24:12 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Problems with ac12 kernels and up
Date: Sun, 27 May 2001 14:24:03 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGOEEGCHAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
In-Reply-To: <E1544Cy-00027I-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> Checking root filesystem. /dev/hde13 is mounted.
>> Cannot continue, aboorting.
>> *** An error occurred during the file system check.
>> *** Dropping you to a shell; the system will reboot
>> *** when you leave the shell.
>
>That means the file system was mounted read/write at boot time. That
normally
>indicates a lilo misconfiguration however your lilo.conf looks
>correct.
>
>Alan

I've built the ac18 kernel with the serial console enabled, and dumped the
results (this is the one that kernel panics).

http://jcwren.com/linux/ac18.txt - ac18 dmesg dump
http://jcwren.com/linux/build.txt - sequence I'm using to build

The apparent interleaved garbage closer to the bottom is exactly what came
out on the console.  (Is linking to the dumps perferred over including it in
the mail, or would folks prefer to have the text included?  Since I'm not a
judge of exactly what you need to see, I'm not sure if 200 lines of dump
would be appropriate or not).

Just for good measure, I've installed the latest RH 7.1 LILO, mkinitrd, and
associated tools.

I also rebuilt the ac12 kernel, and tried again.  Same results as the quoted
text above.

--John

