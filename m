Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136348AbREDMhD>; Fri, 4 May 2001 08:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136354AbREDMgx>; Fri, 4 May 2001 08:36:53 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:39758 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136348AbREDMgo>; Fri, 4 May 2001 08:36:44 -0400
Date: Fri, 4 May 2001 12:26:43 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Dave Mielke <dave@mielke.cc>
Cc: "Linux Kernel (mailing list)" <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Swap space deallocation speed. (fwd)
Message-ID: <20010504122643.A6125@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0105030001060.22875-200000@dave.private.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0105030001060.22875-200000@dave.private.mielke.cc>; from dave@mielke.cc on Thu, May 03, 2001 at 12:03:39AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 03, 2001 at 12:03:39AM -0400, Dave Mielke wrote:

> unresponsive. The relevant line in the log, as you can find in the attached
> "crash.log" file, appears to be:
> 
>     Unable to handle kernel paging request at virtual address 00020024

> Apr 16 11:23:06 dave kernel: esi: 00020000   edi: c14ff5d0   ebp: c3e6a6d0   esp: c142ff30 

This looks like a random bit flip in a page table.  That's almost
always a hardware problem.  Stop overclocking if you are doing that;
check that the CPU fan is still working, etc.

Cheers, 
 Stephen
