Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129276AbRB0TLz>; Tue, 27 Feb 2001 14:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129344AbRB0TLq>; Tue, 27 Feb 2001 14:11:46 -0500
Received: from mercury.ST.HMC.Edu ([134.173.57.219]:18948 "HELO
	mercury.st.hmc.edu") by vger.kernel.org with SMTP
	id <S129276AbRB0TLh>; Tue, 27 Feb 2001 14:11:37 -0500
From: Nate Eldredge <neldredge@hmc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15003.64484.503213.193396@mercury.st.hmc.edu>
Date: Tue, 27 Feb 2001 11:11:32 -0800
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
In-Reply-To: <20010225233957.R7830@suse.de>
In-Reply-To: <15000.9242.867644.29523@mercury.st.hmc.edu>
	<15001.34865.543658.820963@mercury.st.hmc.edu>
	<20010225233957.R7830@suse.de>
X-Mailer: VM 6.76 under Emacs 20.5.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 > On Sun, Feb 25 2001, Nate Eldredge wrote:
 > > Nate Eldredge writes:
 > >  > Kernel 2.4.2-ac3.
 > >  > 
 > >  >  FLAGS   UID   PID  PPID PRI  NI   SIZE   RSS WCHAN       STA TTY TIME COMMAND
 > >  >     40     0   425     1  -1 -20      0     0 down        DW< ?   0:00 (loop0)
 > > 
 > > It looks like this has been addressed in the thread "242-ac3 loop
 > > bug".  Jens Axboe posted a patch, but the list archive I'm reading
 > > mangled it.  Jens, could you make this patch available somewhere, or
 > > at least email me a copy?  (If it's going in an upcoming -ac patch,
 > > then don't bother; I can wait until then.)
 > 
 > Patch is here, I haven't checked whether Alan put it in ac4 yet (I
 > did cc him, but noone knows for sure :-).

It's in 2.4.2-ac5, which does indeed fix the problem.  Thanks to all.

-- 

Nate Eldredge
neldredge@hmc.edu
