Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317325AbSFNLG6>; Fri, 14 Jun 2002 07:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSFNLG5>; Fri, 14 Jun 2002 07:06:57 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:11524 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317325AbSFNLG5>; Fri, 14 Jun 2002 07:06:57 -0400
Message-ID: <3D09CE45.C2D8152B@aitel.hist.no>
Date: Fri, 14 Jun 2002 13:06:45 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Matthew Wakeling <mnw21@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: Very large font size crashing X Font Server and Grounding Serverto a 
 Halt (was: remote DoS in Mozilla 1.0)
In-Reply-To: <Pine.LNX.4.44.0206132255220.4999-100000@server3.jumpleads.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wakeling wrote:
[...]
> However, one circumstance that throwing lots of swap around doesn't
> fix is when a process has an insatiable need for memory. In this case,
> either the process grows very quickly, or is just plain big. I think the
> out-of-memory killer should target big or growing processes. If it doesn't
> hit the correct process the first time, it will free up a lot more RAM
> than it would otherwise, and it would be likely to get it right the second
> time.
> 
A fork bomb would kill everything else in your machine then.  The bomb
program doesn't grow and is smaller than anythine else - but there's 
so many of them.  So all the other useful programs, 
including shells, are killed. :-(

Helge Hafting
