Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271884AbRH1TOM>; Tue, 28 Aug 2001 15:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271886AbRH1TOC>; Tue, 28 Aug 2001 15:14:02 -0400
Received: from mons.uio.no ([129.240.130.14]:33445 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S271884AbRH1TNr>;
	Tue, 28 Aug 2001 15:13:47 -0400
To: Oliver Paukstadt <oliver@paukstadt.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS Client and SMP
In-Reply-To: <Pine.LNX.4.05.10108281806180.20438-100000@lara.stud.fh-heilbronn.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 28 Aug 2001 21:13:55 +0200
In-Reply-To: Oliver Paukstadt's message of "Tue, 28 Aug 2001 18:16:34 +0200 (CEST)"
Message-ID: <shsk7zongjw.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     > HY HY I have massive problems using client nfs on SMP boxes.  I
     > can reproduce it 2.4.[0-7] on s390 and s390x and with 2.4.[0-8]
     > on IA32.

One other thing. If you're running on a Gigabit network, try turning
off jumbo frames - there seems to be some problems still with getting
that to work properly, and it's been known to cause NFS hangs.

Cheers,
  Trond
