Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132565AbRDEGus>; Thu, 5 Apr 2001 02:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRDEGui>; Thu, 5 Apr 2001 02:50:38 -0400
Received: from theirongiant.zip.net.au ([61.8.0.198]:20238 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S132563AbRDEGuh>; Thu, 5 Apr 2001 02:50:37 -0400
Date: Thu, 5 Apr 2001 16:49:54 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-ac2 and D state process
Message-ID: <20010405164954.D432@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have mozilla stuck in D state:

25 [16:44:06] bowman@europa:/home/bowman>> ps -eo pid,tt,user,fname,tmout,f,wchan | grep mozilla
  435 ?        bowman   mozilla-     - 040 down_write_failed
 2646 ?        bowman   mozilla-     - 040 down_write_failed

Would this be a mozilla issue or a kernel issue? I can't kill this sucker
nor can I attache an strace to it and have it return something.

System is a Debian 2.2r2 system, kernel 2.4.3-ac2, glibc 2.1.3
(dunno what else you folks may need - if you do need more info, 
holler)

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

