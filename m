Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTEFUDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTEFUDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:03:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38389 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261292AbTEFUDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:03:14 -0400
Message-ID: <3EB817C9.8020603@mvista.com>
Date: Tue, 06 May 2003 13:15:05 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Andrew Morton <akpm@zip.com.au>, kbuild-devel@lists.sourceforge.net,
       mec@shout.net,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] asm-generic magic
References: <3EB75924.1080304@mvista.com> <1052205991.983.13.camel@rth.ninka.net>
In-Reply-To: <1052205991.983.13.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Mon, 2003-05-05 at 23:41, george anzinger wrote:
> 
>>That is, if the file exists in .../include/asm/ use that one, if not 
>>and it exist in .../include/asm-generic/ use the generic one.
> 
> 
> This is not at all how this stuff is supposed to work.

Um, where might one learn how it is _supposed_ to work?
> 
> You must include them from the asm-${ARCH}/foo.h file.

That still works with this patch, same as with out it.
> 
> Please, don't create this setup.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

