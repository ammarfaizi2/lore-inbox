Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276032AbRJYTdH>; Thu, 25 Oct 2001 15:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276057AbRJYTc7>; Thu, 25 Oct 2001 15:32:59 -0400
Received: from rj.sgi.com ([204.94.215.100]:14255 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276032AbRJYTcu>;
	Thu, 25 Oct 2001 15:32:50 -0400
Date: Thu, 25 Oct 2001 12:33:24 -0700
From: richard offer <offer@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export syscalls
Message-ID: <100000000.1004038404@changeling.engr.sgi.com>
In-Reply-To: <fa.do3ji5v.16nohb9@ifi.uio.no>
In-Reply-To: <fa.do3ji5v.16nohb9@ifi.uio.no>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
X-HomePage: http://www.whitequeen.com/users/richard/
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



* frm hch@caldera.de "10/25/2001 05:25:40 PM +0000" | sed '1,$s/^/* /'
*
* Hi Linus,
* 
* the appended patch exports the syscalls (GPL-limited), this is needed
* for the Linux-ABI modules so they can use the syscalls in their
* syscall tables for non-Linux personalities.


What is the rationale for marking these as GPL-exclusive symbols ? 

I thought system calls were a public interface.

* 	Christoph
* 
* -- 
* Of course it doesn't work. We've performed a software upgrade.

[snip]

* +EXPORT_SYMBOL_GPL(sys_ioctl);
* +EXPORT_SYMBOL_GPL(sys_gettimeofday);

[snip]


richard.
-- 
-----------------------------------------------------------------------
Richard Offer                     Technical Lead, Trust Technology, SGI
"Specialization is for insects"
___________________________________________On sabatical Nov 8 -> Nov 30

