Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbSIUQW0>; Sat, 21 Sep 2002 12:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbSIUQW0>; Sat, 21 Sep 2002 12:22:26 -0400
Received: from franka.aracnet.com ([216.99.193.44]:34196 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262489AbSIUQWZ>; Sat, 21 Sep 2002 12:22:25 -0400
Date: Sat, 21 Sep 2002 09:25:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Florin Iucha <florin@iucha.net>
cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <597384533.1032600316@[10.10.2.3]>
In-Reply-To: <20020921161702.GA709@iucha.net>
References: <20020921161702.GA709@iucha.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > X won't start on 2.5.37, but works with 2.5.36
>> > The screen goes black as usual, but then nothing else happens.
>> > ssh'ing in from another machine shows XFree86 using 50% cpu,
>> > i.e. one of the two cpu's in this machine.
>> 
>> Looks like Linus fixed this already in his BK tree ... want
>> to grab that and see if it fixes your problem?
> 
> What changeset do you think fixed this?

Well, this bit looked hopeful:

23 hours torvalds 1.575 Fix vm86 system call interface to entry.S. 
This has been broken since the thread_info support went in (early July), 
and can cause lockups at X startup etc. 
 

