Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbSITIvC>; Fri, 20 Sep 2002 04:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSITIvC>; Fri, 20 Sep 2002 04:51:02 -0400
Received: from employees.nextframe.net ([212.169.100.200]:50672 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S261744AbSITIvC>; Fri, 20 Sep 2002 04:51:02 -0400
Date: Fri, 20 Sep 2002 11:00:36 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: linux-kernel@vger.kernel.org
Subject: Re:  [OOPS 2.4.19] Unable to handle kernel paging request at virtual address 7ec64585
Message-ID: <20020920110036.A6880@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <20020917133338.B762@sexything> <20020918131414.G762@sexything>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020918131414.G762@sexything>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 01:14:14PM +0200, Morten Helgesen wrote:
> Hey again, 
> 
> now have a look at this - happens on the same box as the
> oops I reported yesterday. EIP still in iput(), but this time we were
> obviosuly working with swap instead of memory . This time
> it`s kswapd, and after the oops kswapd is :
> 
> [13:19][admin@sql:~]$ ps -ewo user,pid,priority,stat,command,wchan | grep kswapd
> root         4   9 Z    [kswapd <defunct do_exit
> 
> This is not cool guys - no one else seing this ? 2.4.18 was running just fine
> on this box. I`m going back to 2.4.18 now and I`ll see if this keeps happening ... if
> it does it might be hardware related (even though that does not seem very likely) - as I
> said, the box has been running just fine with 2.4.18 for a long time.
> 

Just for the record - 2.4.18 works like a charm.

[snip]

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
