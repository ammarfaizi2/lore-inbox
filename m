Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264952AbRGIOrR>; Mon, 9 Jul 2001 10:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264924AbRGIOrH>; Mon, 9 Jul 2001 10:47:07 -0400
Received: from dnscache.cbr.au.asiaonline.net ([210.215.8.100]:40066 "EHLO
	dnscache.cbr.au.asiaonline.net") by vger.kernel.org with ESMTP
	id <S264954AbRGIOqx>; Mon, 9 Jul 2001 10:46:53 -0400
Message-ID: <3B49C3C5.1A852029@acm.org>
Date: Tue, 10 Jul 2001 00:46:29 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ernest N. Mamikonyan" <ernest@newton.physics.drexel.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: increasing the TASK_SIZE
In-Reply-To: <3B44DA51.10D3F0C0@newton.physics.drexel.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ernest N. Mamikonyan" wrote:
> 
> I was wondering how I can increase the process address space, TASK_SIZE
> (PAGE_OFFSET), in the current kernel. It looks like the 3 GB value is
> hardcoded in a couple of places and is thus not trivial to alter. Is
> there any good reason to limit this value at all, why not just have it
> be the same as the max addressable space (64 GB)? We have an ix86 SMP
> box with 4 GB of RAM and want to be able to allocate all of it to a
> single program (physics simulation). I would greatly appreciate any help
> on this.

Sounds like you just need to enable highmem.  Check the help for "High
Memory Support" in "Processor type and features".

-- Gareth
