Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbQJaWmM>; Tue, 31 Oct 2000 17:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbQJaWmD>; Tue, 31 Oct 2000 17:42:03 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19467 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129181AbQJaWl5>; Tue, 31 Oct 2000 17:41:57 -0500
Message-ID: <39FF49C8.475C2EA7@timpanogas.org>
Date: Tue, 31 Oct 2000 15:38:00 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Paul Menage <pmenage@ensim.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Larry McVoy wrote:
> 
> On Tue, Oct 31, 2000 at 03:15:37PM -0700, Jeff V. Merkey wrote:
> > The quality of the networking code in Linux is quite excellent.  There's
> > some scaling problems relative to NetWare.  We are firmly committed to
> > getting something out with a Linux code base and NetWare metrics.  Love
> > to have your help.
> 
> Jeff, I'm a little concerned with some of your statements.  Netware may
> be the greatest thing since sliced bread, but it isn't a full operating
> system, so comparing it to Linux is sort of meaningless.

It's makes more money in a week than Linux has ever made.  

  Consider your
> recent context switch claims.  Yes, I believe that you can do the moral
> equiv of a longjmp() in the kernel in a few cycles, but that isn't a
> context switch, at least, it isn't the same a context switch in the
> operating system sense.  
A context switch in anoperating system context in it's simplest for is

mov    x, esp
mov    esp, y

It's different - last I checked, Netware was
> essentially a kernel and nothing else.  


Is there a file system?
Several.

  Are there
> processes with virtual memory?
Yes.

  Are they preemptive?
Yes.

  Does it support
> all of P1003.1?  
Yes.

Etc.  If the answers to all of the above are "yes"
> and you can support all that and get user to user context switches in a
> clock cycle, well, jeez, you really do walk on water and I'll publicly
> apologize for ever doubting your statements.  

Apology accepted.

Jeff


> --
> ---
> Larry McVoy              lm at bitmover.com           http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
