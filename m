Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129567AbRCAJjv>; Thu, 1 Mar 2001 04:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRCAJjb>; Thu, 1 Mar 2001 04:39:31 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:7684 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129567AbRCAJj2>; Thu, 1 Mar 2001 04:39:28 -0500
Message-ID: <3A9E1864.C55FCA9C@idb.hist.no>
Date: Thu, 01 Mar 2001 10:37:40 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Neelam Saboo <neelam_saboo@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: [Re: paging behavior in Linux]
In-Reply-To: <20010228230809.11894.qmail@nwcst314.netaddress.usa.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neelam Saboo wrote:
> 
> Another observation. I have two independent programs. One program incurring
> page faults and another program just doing some work.
> When work program run undependently it takes ~19 seconds of CPU time, but when
> it is run along with page faulting program on the same machine, it takes ~32
> seconds of CPU time. Doesnt this indicate that page faults in a program slows
> down all the program on the machine and not only threads in the same process
> ?
Is this really CPU time or merely wall clock time?  The latter will
obviously increase as running two programs takes more time than running
one.

Helge Hafting
