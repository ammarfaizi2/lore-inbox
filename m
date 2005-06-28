Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVF1Q1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVF1Q1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVF1Q1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:27:20 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:701 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262141AbVF1Q0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:26:30 -0400
Message-ID: <42C179D5.3040603@nodivisions.com>
Date: Tue, 28 Jun 2005 12:24:53 -0400
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oom-killings, but I'm not out of memory!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running a 2.6.11 kernel.  I have 1 gig of RAM and 1 gig of swap.  Lately 
when my RAM gets full, the oom-killer takes out either Mozilla or 
Thunderbird (my two biggest memory hogs), even though my swap space is only 
20% full.  I still have ~800 MB of free swap space, so shouldn't the kernel 
push Moz or T-bird into swap instead of oom-killing it?  At their maximum 
memory-hogging capacity, neither Moz nor T-bird is ever using more than 200 MB.

Thanks,
Anthony DiSante
http://nodivisions.com/


Jun 28 12:09:09 soma oom-killer: gfp_mask=0x80d2
...
Jun 28 12:09:09 soma Free swap  = 781012kB
Jun 28 12:09:09 soma Total swap = 987988kB
Jun 28 12:09:09 soma Out of Memory: Killed process 30787 (thunderbird-bin).
Jun 28 12:09:09 soma Out of Memory: Killed process 18112 (thunderbird-bin).
Jun 28 12:09:09 soma Out of Memory: Killed process 18116 (thunderbird-bin).
Jun 28 12:09:09 soma Out of Memory: Killed process 18117 (thunderbird-bin).
Jun 28 12:09:09 soma Out of Memory: Killed process 18119 (thunderbird-bin).
Jun 28 12:09:09 soma Out of Memory: Killed process 8857 (thunderbird-bin).

