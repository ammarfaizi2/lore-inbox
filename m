Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130321AbRAMORE>; Sat, 13 Jan 2001 09:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbRAMOQz>; Sat, 13 Jan 2001 09:16:55 -0500
Received: from james.kalifornia.com ([208.179.0.2]:604 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S130321AbRAMOQr>; Sat, 13 Jan 2001 09:16:47 -0500
Message-ID: <3A60634A.54BB21ED@linux.com>
Date: Sat, 13 Jan 2001 06:16:42 -0800
From: David Ford <david@linux.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: david+validemail@kalifornia.com, linux-kernel@vger.kernel.org
Subject: Re: shmem or swapfs? was: [Patch] make shm filesystem part configurable
In-Reply-To: <m366jj20si.fsf@linux.local> <3A604B26.53EC029F@linux.com> <m33denk0p2.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is a filesystem which lives in RAM and can swap out. SYSV shm and
> shared anonymous maps are still build on top of this (The config
> option only disables the part not needed for this).
>
> I am quite open about naming, but "shm" is not appropriate any more
> since the fs does a lot more than shared memory. Solaris calles this
> "tmpfs" but I did not want to 'steal' their name and I also do not
> think that it's a very good name.
>
> So any suggestions for a better name?

Hmm, ok, what are the activities that use this other than shm?

-d

-- ---NOTICE

-- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
