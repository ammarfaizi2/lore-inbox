Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129265AbQKQW6R>; Fri, 17 Nov 2000 17:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQKQW6H>; Fri, 17 Nov 2000 17:58:07 -0500
Received: from SMTP2.ANDREW.CMU.EDU ([128.2.10.82]:37548 "EHLO
	smtp2.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S129265AbQKQW6A>; Fri, 17 Nov 2000 17:58:00 -0500
Date: Fri, 17 Nov 2000 17:28:37 -0500
From: Frank Davis <fdavis@andrew.cmu.edu>
To: Tobias Ringstrom <tori@tellus.mine.nu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] dmfe.c network driver update for 2.4
Message-ID: <3819508582.974482117@primetime2>
In-Reply-To: <Pine.LNX.4.21.0011171018130.24487-100000@svea.tellus>
Originator-Info: login-token=Mulberry:0118xnwD0wyDYSSrY3IkzeLyop3uxdN/QFL9Q11zzaSQ==;
 token_authority=postmaster@andrew.cmu.edu
X-Mailer: Mulberry/2.0.3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I would rather fix those non-SMP compliant drivers to be SMP compliant, 
then keeping them 'broken'. Adding the print statements would only be a 
temporary solution.

Regards,
Frank

--On Friday, November 17, 2000 10:20 AM +0100 Tobias Ringstrom
> How about adding an ifdef CONFIG_SMP then print ugly warning to all known
> SMP unsafe drivers? A message could be printed booth at compile and load
> time.
>
> /Tobias
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
