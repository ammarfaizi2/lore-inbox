Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbRAMOAn>; Sat, 13 Jan 2001 09:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAMOAY>; Sat, 13 Jan 2001 09:00:24 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:17848 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129859AbRAMOAV>; Sat, 13 Jan 2001 09:00:21 -0500
To: david+validemail@kalifornia.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmem or swapfs? was: [Patch] make shm filesystem part configurable
In-Reply-To: <m366jj20si.fsf@linux.local> <3A604B26.53EC029F@linux.com>
From: Christoph Rohland <cr@sap.com>
Date: 13 Jan 2001 15:04:41 +0100
In-Reply-To: <3A604B26.53EC029F@linux.com>
Message-ID: <m33denk0p2.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david@linux.com> writes:

> Now...is this shared memory or swap?  If it's swap, why is it
> different than a swapfile?  If you are intending the shmem be called
> swapfs, I personally thing that it'll cause a significant amount of
> confusion.

It is a filesystem which lives in RAM and can swap out. SYSV shm and
shared anonymous maps are still build on top of this (The config
option only disables the part not needed for this).

I am quite open about naming, but "shm" is not appropriate any more
since the fs does a lot more than shared memory. Solaris calles this
"tmpfs" but I did not want to 'steal' their name and I also do not
think that it's a very good name.

So any suggestions for a better name?

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
