Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314095AbSEAXOm>; Wed, 1 May 2002 19:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314094AbSEAXOl>; Wed, 1 May 2002 19:14:41 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:22034 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S314095AbSEAXOj>; Wed, 1 May 2002 19:14:39 -0400
Message-ID: <3CD07654.50000@megapathdsl.net>
Date: Wed, 01 May 2002 16:12:20 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020426
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.5.10 problems	
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
 > On 27 Apr 2002 11:32:46 -0700, Miles Lane <miles@megapathdsl.net> wrote:
 > >My plan is to run "strace wombat", "strace evolution-mail" and
 > >"strace evolution-addressbook" in separate terminal windows.
 > >The evolution process can then be started normally. 
 >
 > What state are the tasks in when it hangs, S, R, D, N, T, what?  I have
 > an intermittent problem on 2.4 where an entire process group goes into
 > T state even though nothing is tracing it.  Killing the offending
 > process then sending SIGCONT to the rest of the process group restarts
 > the group.  The offending process is usually the last one on the tree.

Hmm.  I checked while running 2.5.12 (it still hangs) and
all the Evolution-related processes were in "S" state after
the hang.

Other ideas for me to explore?

Thanks,
	Miles

