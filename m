Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbUAZVqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUAZVqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:46:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56829 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265466AbUAZVqT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:46:19 -0500
Message-ID: <40158A88.7070007@mvista.com>
Date: Mon, 26 Jan 2004 13:45:44 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: PPC KGDB changes and some help?
References: <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <20040121192230.GW13454@stop.crashing.org> <20040122174416.GJ15271@stop.crashing.org> <20040122180555.GK15271@stop.crashing.org> <20040123224605.GC15271@stop.crashing.org> <4011B07F.5060409@mvista.com> <20040126204631.GB32525@stop.crashing.org>
In-Reply-To: <20040126204631.GB32525@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
>>There is a real danger of passing signal info back to gdb as it will want 
>>to try to deliver the signal which is a non-compute in most kgdbs in the 
>>field.  I did put code in the mm-kgdb to do just this, but usually the 
>>arrival of such a signal (other than SIGTRAP) is the end of the kernel.  
>>All that is left is to read the tea leaves.
> 
> 
> The gdb I've been testing this with knows better than to try and send a
> singal back, so that's not a worry.  The motivation behind doing this
> however is along the lines of "if it ain't broke, don't remove it".  The
> original stub was getting all of this information correctly, so why stop
> doing it?
> 
You sure.  If so what gdb?  And how does it know?  I suppose you could tell it 
with a script, but then what if one forgets?

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

