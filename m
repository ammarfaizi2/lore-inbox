Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131613AbQKVEQ6>; Tue, 21 Nov 2000 23:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131227AbQKVEQs>; Tue, 21 Nov 2000 23:16:48 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:39819 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S131125AbQKVEQk>; Tue, 21 Nov 2000 23:16:40 -0500
Date: Wed, 22 Nov 2000 04:46:32 +0100
From: David Weinehall <tao@acc.umu.se>
To: Joseph Gooch <mrwizard@psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECN causing problems
Message-ID: <20001122044632.C22498@pund.acc.umu.se>
In-Reply-To: <006301c05433$feb8c0c0$0200020a@wizws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <006301c05433$feb8c0c0$0200020a@wizws>; from mrwizard@psu.edu on Tue, Nov 21, 2000 at 10:26:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 10:26:24PM -0500, Joseph Gooch wrote:
> My RaptorNT 6.5 firewall rejects all connections from my linux box when ECN
> is enabled.  The error is attached.  Perhaps this feature should be disabled
> by default?  Or is there already an option of the sort that i'm missing?  I
> only got the idea to disable it after a search of linux-kernel.

I suggest you file a bugreport against RaptorNT, which evidently is
malfunctioning by detecting legit TCP-flags as something illegal.

> Plz cc me, I"m not on the list.
> 
> Later!
> Joe Gooch
> 
> TCP packet dropped (10.204.186.7->x.x.x.x: Protocol=TCP[SYN 0xc0] Port
> 1255->2401): Bad TCP flags combination (received on interface 192.168.1.1)
> (probable QueSO probe as flags=0xc2)


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
