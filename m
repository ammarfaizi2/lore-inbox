Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQKUP1g>; Tue, 21 Nov 2000 10:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130265AbQKUP11>; Tue, 21 Nov 2000 10:27:27 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:63500 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129752AbQKUP1M>;
	Tue, 21 Nov 2000 10:27:12 -0500
To: rml@ufl.edu
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [WEIRD] working kernel off RH7's gcc-2.96!?
In-Reply-To: <974783952.3a1a05d0c4840@webmail.ufl.edu>
From: Jes Sorensen <jes@linuxcare.com>
Date: 21 Nov 2000 15:57:03 +0100
In-Reply-To: rml@ufl.edu's message of "Tue, 21 Nov 2000 00:19:12 -0500"
Message-ID: <d33dglbcg0.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Robert" == rml  <rml@ufl.edu> writes:

Robert> i dont want to revisit the flame fest (at all, please) but it
Robert> seems i have been using a kernel that successfully compiled
Robert> under RedHat 7's gcc snapshot (2.96).  i normally use
Robert> gcc-2.91.66 for everything (mv kgcc gcc) but just synced my
Robert> system with rawhide, so the gcc/kgcc pair is back on my system
Robert> and i forgot. so i recompiled to test11 yesterday, and:

[snip]

Robert> the odd thing is, not only did it compile, but my machine has
Robert> been up for a day with heavy use in X with a full-featured
Robert> kernel! not only no OOPSs, but no bugs!

Just keep in mind that 'seems to run fine' doesn't clearly show cases
like something in the signal handling code got miscompiled for a
special case or a bit error in the file system code. You could be
lucky, it might also show itself as more frequent crashes later etc.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
