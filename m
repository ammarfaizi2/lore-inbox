Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293659AbSCSEdE>; Mon, 18 Mar 2002 23:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293648AbSCSEco>; Mon, 18 Mar 2002 23:32:44 -0500
Received: from [202.135.142.196] ([202.135.142.196]:13070 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S293647AbSCSEck>; Mon, 18 Mar 2002 23:32:40 -0500
Date: Tue, 19 Mar 2002 15:34:36 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@transmeta.com, yodaiken@fsmlabs.com, ak@suse.de, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-Id: <20020319153436.62a498ef.rusty@rustcorp.com.au>
In-Reply-To: <20020316212229.B25796@wotan.suse.de>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002 21:22:29 +0100
Andi Kleen <ak@suse.de> wrote:

> On Sat, Mar 16, 2002 at 12:14:06PM -0800, Linus Torvalds wrote:
> > Give up on large pages - it's just not happening. Even when a 64kB page 
> > would make sense from a technology standpoint these days, backwards 
> > compatibility makes people stay at 4kB.
> 
> Yes the 4KB page has to be kept at least for now. 

We have sysconf(_SC_PAGESIZE).  I say, introduce an experimental CONFIG for
64k pagesize in 2.5, so we can start to weed out the problem apps NOW.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
