Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbTBPHEw>; Sun, 16 Feb 2003 02:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbTBPHEw>; Sun, 16 Feb 2003 02:04:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16367 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265947AbTBPHEv>;
	Sun, 16 Feb 2003 02:04:51 -0500
Message-ID: <3E4F3A40.3090502@mvista.com>
Date: Sat, 15 Feb 2003 23:14:08 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Wuertele <dave-gnus@bfnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: how to interactively break gdb debugging kernel over serial?
References: <20030214234557.GC13336@doc.pdx.osdl.net> <m38ywia054.fsf@bfnet.com>
In-Reply-To: <m38ywia054.fsf@bfnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wuertele wrote:
> I'm debugging the kernel with gdb over a serial port.  Breakpoints and
> stepping through code works great, except for the fact that once the
> kernel is running, I can't seem to use Control-C to stop it.  Is there
> a keypress or other interactive way to break a running kernel?
> 
> Thanks,
> Dave
> 
Dave,

There are a great number of kgdb patches in the wild.  You would help 
us out a lot if you were to name the one you are using.  If you are on 
then 2.5 kernel I suggest you check out Andrew Morton's area and use 
that one.

If you are using the one from source forge on a 2.4 kernel, there is a 
mailing list for it that can be found at the same sourceforge site.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

