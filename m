Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268073AbTBRWjj>; Tue, 18 Feb 2003 17:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268074AbTBRWjj>; Tue, 18 Feb 2003 17:39:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:12279 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S268073AbTBRWjh>;
	Tue, 18 Feb 2003 17:39:37 -0500
Message-ID: <3E52B866.7060901@mvista.com>
Date: Tue, 18 Feb 2003 14:49:10 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Wuertele <dave-gnus@bfnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: how to interactively break gdb debugging kernel over serial?
References: <20030214234557.GC13336@doc.pdx.osdl.net> <m38ywia054.fsf@bfnet.com> <3E4F3A40.3090502@mvista.com> <m38ywd72ba.fsf@bfnet.com>
In-Reply-To: <m38ywd72ba.fsf@bfnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wuertele wrote:
>>>I'm debugging the kernel with gdb over a serial port.  Breakpoints and
>>>stepping through code works great, except for the fact that once the
>>>kernel is running, I can't seem to use Control-C to stop it.  Is there
>>>a keypress or other interactive way to break a running kernel?
>>>Thanks,
>>>Dave
> 
> 
> george> There are a great number of kgdb patches in the wild.  You
> george> would help us out a lot if you were to name the one you are
> george> using.
> 
> Here's the output from gdb --version:
> 
> GNU gdb Red Hat Linux (5.1.90CVS-5)
> Copyright 2002 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "i386-redhat-linux".
> 
> Does that help?

NO :(  It is the KGDB patch that you are using that is of interest 
here,  not the gdb program.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

