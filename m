Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129753AbQKABDP>; Tue, 31 Oct 2000 20:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130696AbQKABDE>; Tue, 31 Oct 2000 20:03:04 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:22932 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129753AbQKABCz>; Tue, 31 Oct 2000 20:02:55 -0500
From: kumon@flab.fujitsu.co.jp
Date: Wed, 1 Nov 2000 10:02:40 +0900
Message-Id: <200011010102.KAA16382@asami.proc.flab.fujitsu.co.jp>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39FEE701.CAC21AE5@uow.edu.au>
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>
	<39F92187.A7621A09@timpanogas.org>
	<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
	<20001027094613.A18382@gruyere.muc.suse.de>
	<200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp>
	<39FEE701.CAC21AE5@uow.edu.au>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton writes:
 > how many Apache processes are you running? MaxSpareServers?

MinSpareServers		16
MaxSpareServers		20
StartServers		16
MaxClients		64
MaxRequestsPerChild	0

During busy duration, 64 server processes are working if requests are
processed without trouble.
32 client systems are used and 2 request threads are run on each.

 > performance of Apache when the file-locking serialisation is
 > disabled.

Making apache without locking is now on-going.
# LinuxWorld conference held in Tokyo these two days, may be an
# obstacle.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
