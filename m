Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbQJaW15>; Tue, 31 Oct 2000 17:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129119AbQJaW1s>; Tue, 31 Oct 2000 17:27:48 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:62552
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S129050AbQJaW1f>; Tue, 31 Oct 2000 17:27:35 -0500
Date: Tue, 31 Oct 2000 14:27:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Larry McVoy <lm@bitmover.com>, Paul Menage <pmenage@ensim.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031142733.A23516@work.bitmover.com>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
	Larry McVoy <lm@bitmover.com>, Paul Menage <pmenage@ensim.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <39FF4488.83B6C1CE@timpanogas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 03:15:37PM -0700, Jeff V. Merkey wrote:
> The quality of the networking code in Linux is quite excellent.  There's
> some scaling problems relative to NetWare.  We are firmly committed to
> getting something out with a Linux code base and NetWare metrics.  Love
> to have your help.

Jeff, I'm a little concerned with some of your statements.  Netware may
be the greatest thing since sliced bread, but it isn't a full operating
system, so comparing it to Linux is sort of meaningless.  Consider your
recent context switch claims.  Yes, I believe that you can do the moral
equiv of a longjmp() in the kernel in a few cycles, but that isn't a
context switch, at least, it isn't the same a context switch in the
operating system sense.  It's different - last I checked, Netware was
essentially a kernel and nothing else.  Is there a file system?  Are there
processes with virtual memory?  Are they preemptive?  Does it support
all of P1003.1?  Etc.  If the answers to all of the above are "yes"
and you can support all that and get user to user context switches in a
clock cycle, well, jeez, you really do walk on water and I'll publicly
apologize for ever doubting your statements.  On the other hand, if the
answers to that are not all "yes", then how about you do a little truth
in advertising with your postings?  Without it, they are misleading to
the point of being purposefully deceptive.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
