Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTLJW6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTLJW6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:58:45 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:19129 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261411AbTLJW6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:58:43 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: floppy.c problems?
Date: Wed, 10 Dec 2003 17:58:41 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101758.41498.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.60.44] at Wed, 10 Dec 2003 16:58:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all; Slightly offtopic but maybe I can find some info here.

I have a requirement to format and use a floppy, either mechanical 
size, 256 byte sector, 18 sectors per track at 250kilobaud data rate.  
I have been assured that the "superio' chip on my mobo can indeed do 
that format.  Soooo...

I've added 4 more lines to the floppy definition array in floppy.c, 
and increased the array count at the top to match, but I don't seem 
to be able to get any output, its working as usual.  Stuck in 512 
bytes per sector modes, 9 to the track that is.

I even turned on several debugging options, but haven't found out 
where the logging is going if its working.  Looks like if its doing 
any debugging outputs, they're being sent to /dev/null.

Ideas?

Secondary problem too, I have a zombie of minicom that I can't kill.  
Its sleeping for disk access or some such twaddle.  It always trashes 
the X window cli screen I run it in, and often locks up like a piece 
of MS software from 1983.  Surely that thing has been cleaned up and 
'sane'itized for use with x somewhere along the line.  Or am I useing 
the wrong comm terminal utility in the first place?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

