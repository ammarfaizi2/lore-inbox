Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130657AbQKUOb7>; Tue, 21 Nov 2000 09:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130676AbQKUObt>; Tue, 21 Nov 2000 09:31:49 -0500
Received: from slip202-135-75-88.ca.au.ibm.net ([202.135.75.88]:30852 "EHLO
	krispykreme") by vger.kernel.org with ESMTP id <S130657AbQKUObi>;
	Tue, 21 Nov 2000 09:31:38 -0500
Date: Wed, 22 Nov 2000 01:00:49 +1100
To: Rafal Maszkowski <rzm@icm.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test11-pre2 (ksymoops output)
Message-ID: <20001122010049.G3430@linuxcare.com>
In-Reply-To: <Pine.LNX.4.10.10011091748300.2316-100000@penguin.transmeta.com> <20001110202747.A16806@burza.icm.edu.pl> <20001110150652.F27422@cs.cmu.edu> <20001111020839.A29815@burza.icm.edu.pl> <20001113014201.A28197@burza.icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001113014201.A28197@burza.icm.edu.pl>; from rzm@icm.edu.pl on Mon, Nov 13, 2000 at 01:42:01AM +0100
From: Anton Blanchard <anton@linuxcare.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unable to handle kernel paging request at virtual address fd000000

...
 
> >>PC;  f01a77ac <auxio_probe+14c/160>   <=====

Basically the first thing we tried to map in (the auxio register) failed.
Sounds like the page tables weren't set up properly. It is surely my
fault, I'll try and find out why.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
