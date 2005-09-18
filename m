Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVIRATO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVIRATO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 20:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVIRATO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 20:19:14 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:16058 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1751240AbVIRATN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 20:19:13 -0400
Mime-Version: 1.0
Message-Id: <a0623096fbf5261b770eb@[129.98.90.227]>
In-Reply-To: <mailman.3.1123153201.10574.linux-kernel-daily-digest@lists.us.dell.com>
References: <mailman.3.1123153201.10574.linux-kernel-daily-digest@lists.us.dell.com>
Date: Sat, 17 Sep 2005 20:20:40 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: Segfaults in mkdir under high load. Software or hardware?
Cc: colding@omesc.com, bert.hubert@netherlabs.nl
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > I am experiencing segfaults in mkdir, and mkdir alone, under high load.
>
>I've seen errors like these happen, and they were kernel bugs.
>
>>  [    0.000000] Bootdata ok (command line is root=/dev/sda4 
>>vga=0x31B video=vesafb:mtrr,ywrap)
>  > [    0.000000] Linux version 2.6.12-gentoo-r6 (root@omc-2) (gcc 
>version 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #6 
>SMP Mon Jul 25 13:50:58 CEST 2005
>
>If you reproduce with an unpatched kernel and an unpatched compiler, you are
>much more likely to get attention. Your problem might also just go away.

I have been seeing a similar thing:

./current:Sep 17 18:00:01 [kernel] mkdir[7696]: segfault at 
0000000000000000 rip 000000000040184d rsp 00007fffff826350 error 4

I'm using the plain 2.6.13 (from gentoo vanilla sources), though it 
was compiled with
gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
