Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbRGKPiU>; Wed, 11 Jul 2001 11:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbRGKPiK>; Wed, 11 Jul 2001 11:38:10 -0400
Received: from [195.166.20.93] ([195.166.20.93]:5637 "EHLO
	frumious.unidec.co.uk") by vger.kernel.org with ESMTP
	id <S266723AbRGKPh7>; Wed, 11 Jul 2001 11:37:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: dr john halewood <john@frumious.unidec.co.uk>
Reply-To: john@unidec.co.uk
To: "Richard Purdie" <rpurdie@cableinet.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: <BUG Report: kernel BUG at slab.c:1062! from pppd with speedtouch drivers and pppoatm>
Date: Wed, 11 Jul 2001 16:37:54 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <007501c10a1b$bc3a0bc0$0301a8c0@rpnet.com>
In-Reply-To: <007501c10a1b$bc3a0bc0$0301a8c0@rpnet.com>
MIME-Version: 1.0
Message-Id: <01071116375404.29517@frumious.unidec.co.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 July 2001 16:11, Richard Purdie wrote:
> [1.] One line summary of the problem:
>
> BUG Report: kernel BUG at slab.c:1062!

Just to check: I got exactly the same thing, and a very similar oops (EIP in 
kmem_cache_grow &c) when trying to load sb.o & opl3.o under 2.4.7-pre5. It 
was caused by the fact that I hadn't updated /etc/modules.conf to point to 
the correct directory, and the kernel was trying to load modules from 2.4.5. 
Can you check to make sure that the modules being loaded are the correct ones 
for the kernel version?

cheers
john
