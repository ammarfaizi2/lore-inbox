Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270299AbRH1S5b>; Tue, 28 Aug 2001 14:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271283AbRH1S5V>; Tue, 28 Aug 2001 14:57:21 -0400
Received: from pat.uio.no ([129.240.130.16]:60853 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S270299AbRH1S5K>;
	Tue, 28 Aug 2001 14:57:10 -0400
To: Oliver Paukstadt <oliver@paukstadt.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS Client and SMP
In-Reply-To: <Pine.LNX.4.05.10108281806180.20438-100000@lara.stud.fh-heilbronn.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 28 Aug 2001 20:57:22 +0200
In-Reply-To: Oliver Paukstadt's message of "Tue, 28 Aug 2001 18:16:34 +0200 (CEST)"
Message-ID: <shsitf82est.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     > HY HY I have massive problems using client nfs on SMP boxes.  I
     > can reproduce it 2.4.[0-7] on s390 and s390x and with 2.4.[0-8]
     > on IA32.

What do you mean by 'hang' in this context? Does the entire machine
die, or is it just the nfs mount?

Also, can you reproduce it with the patch

  http://www.fys.uio.no/~trondmy/src/2.4.9/linux-2.4.9-rpc_smpfixes.dif

(the same patch applies fine to 2.4.[678] if you for some reason don't
like 2.4.9)

Cheers,
  Trond
