Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbTHWRUg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTHWRA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:00:26 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:20669 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262904AbTHWQYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 12:24:24 -0400
Message-ID: <3F4798B5.7040109@kegel.com>
Date: Sat, 23 Aug 2003 09:39:17 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Mehmet Ali Suzen <msuzen@mail.north-cyprus.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Running SMP 2.4.21 #2 SMP Kernel on single processor : Memory
 Leakage?
References: <3F46511D.9080108@kegel.com> <20030823152455.A1771@mail.north-cyprus.net>
In-Reply-To: <20030823152455.A1771@mail.north-cyprus.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mehmet Ali Suzen wrote:
>>> I am running RedHat Linux 9 Linux 2.4.21 SMP  ...
>>
>>Then you should contact a Red Hat Linux forum for support.
> 
> it was a compiled kernel.

Ah, if you were running a kernel.org kernel, apologies.

> I am running RedHat Linux 9 Linux 2.4.21 SMP and 
> memory usage is increasing regularly even if 
> no heavy service like (radiusd,mysqld, httpd, named) is not
> running. After some time I get Out of Memory 
> messages and system hungs!
> 
> It sounds stupid but we are running single cpu.
> Would it be possible to have a memory leakage due to SMP 
> operations? Board is Intel Server Board SE7501BR2

I haven't seen the problem you describe, so I'm shooting in
the dark, but:

How long does the problem take to occur after boot?
What kind of load are you putting on the system?
Have you checked the output of ps and /proc/slabinfo to
look for obvious bloats?

- Dan
-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

