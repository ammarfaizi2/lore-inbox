Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272596AbRHaD7Q>; Thu, 30 Aug 2001 23:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272597AbRHaD7G>; Thu, 30 Aug 2001 23:59:06 -0400
Received: from vpop1-014.pacificnet.net ([209.204.32.14]:260 "HELO pobox.com")
	by vger.kernel.org with SMTP id <S272596AbRHaD6z>;
	Thu, 30 Aug 2001 23:58:55 -0400
Subject: Re: Apollo Pro266 system freeze followup
To: jfduff@mtu.edu (John Duff)
Date: Thu, 30 Aug 2001 20:31:07 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, rjh@groucho.maths.monash.edu.au,
        barryn@pobox.com
In-Reply-To: <no.id> from "John Duff" at Aug 28, 2001 08:20:48 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010831033108.34B3EB9FCE@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now I'm running Linux 2.4.9-ac4, compiled for SMP, with the
following loop (in bash):

while : ; do make dep ; make clean ; make -j3 modules bzImage ; done

It's been going for about 7 and a half hours without a lockup, so far.
Note that I am not using the on-board IDE -- but I did not need the
on-board IDE for my lockups either.

If 2.4.9-ac4 still produces lockups for people, it might be interesting
to try 2.2.19 or 2.2.20pre9, compiled for SMP, and see if the lockups
still happen then.

-Barry K. Nathan <barryn@pobox.com>
