Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbQKCBCk>; Thu, 2 Nov 2000 20:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130218AbQKCBCa>; Thu, 2 Nov 2000 20:02:30 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:26809 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S130036AbQKCBCY>; Thu, 2 Nov 2000 20:02:24 -0500
Date: Fri, 3 Nov 2000 02:02:16 +0100
From: David Weinehall <tao@acc.umu.se>
To: Elizabeth Morris-Baker <eamb@liu.fafner.com>
Cc: Torben Mathiasen <torben@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: scsi init problem in 2.4.0-test10? [PATCH]
Message-ID: <20001103020216.A29681@khan.acc.umu.se>
In-Reply-To: <20001103005034.C1353@torben> <200011030024.SAA08567@liu.fafner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200011030024.SAA08567@liu.fafner.com>; from eamb@liu.fafner.com on Thu, Nov 02, 2000 at 06:24:47PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 06:24:47PM -0600, Elizabeth Morris-Baker wrote:
> > 
> 
> 	Yes, I know that is in the spec, but truly,
> 	some scsi devices do act this way....
> 	Maybe they need to read the spec :>
> 
> 	I have included the START_STOP for Matthew, but
> 	I never see it execute with the ATLAS disks...
> 	A diff follows for those that want to try it..
> 
> 	cheers, 
> 
> 	Elizabeth

Well, if I'm not all mistaken, this is the code that got removed earlier
on from the kernel because it caused some SCSI-adapters to hang on
scsi-scan?! If so, what's better: to follow the specs and penalise the
bad guys, or ignore the specs and penalise the good guys...


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
