Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317790AbSHAWKn>; Thu, 1 Aug 2002 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317819AbSHAWKn>; Thu, 1 Aug 2002 18:10:43 -0400
Received: from [195.223.140.120] ([195.223.140.120]:14949 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317790AbSHAWKm>; Thu, 1 Aug 2002 18:10:42 -0400
Date: Fri, 2 Aug 2002 00:14:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Terrible VM in 2.4.19rc3aa4 once again?
Message-ID: <20020801221411.GI11749@dualathlon.random>
References: <1026167822.16937.5.camel@UberGeek> <20020709005025.B1745@mail.muni.cz> <20020708225816.GA1948@werewolf.able.es> <20020709124807.D1510@mail.muni.cz> <20020710163422.GB2513@dualathlon.random> <20020801113124.GA755@mail.muni.cz> <20020801140348.GM1132@dualathlon.random> <20020801141940.GB755@mail.muni.cz> <20020801153911.GC1132@dualathlon.random> <20020801220143.GC755@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801220143.GC755@mail.muni.cz>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 12:01:43AM +0200, Lukas Hejtmanek wrote:
> 
> One more thing, this version seems to swap a lot more than 2.4.18rc4aa2 did.
> 
> The old one swapped only if scsi-ide emulation was used and I think it was only
> about 10mb. How it swaps more, it's common to have 100mb swapped out. I have
> 512mb ram...

may be an internal vm change but could you first check the difference
between ps xav, /proc/meminfo and /proc/slabinfo to see if some of the
vm users changed significantly? (feel free to post me that information
too so I can double check) thanks,

Andrea
