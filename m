Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271809AbRIYWHR>; Tue, 25 Sep 2001 18:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271747AbRIYWG6>; Tue, 25 Sep 2001 18:06:58 -0400
Received: from atlrel7.hp.com ([192.151.27.9]:7953 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S271514AbRIYWGr>;
	Tue, 25 Sep 2001 18:06:47 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D54A@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "'Andrew Morton'" <akpm@zip.com.au>,
        "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: RE: 2.4.10 still slow compared to 2.4.5pre1
Date: Tue, 25 Sep 2001 18:06:59 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> With a synchronous NFS export, I'd expect the disk throughput
> to be lowered to such an extent that VM issues were not
> significant in throughput.  But you have been seeing kswapd
> problems so hmmm...

We are comparing synchronous to synchronous between 2.4.5pre1 and 2.4.10 so
I wouldn't expect such a difference.
  
> Conceivably this is a networking problem, and not an FS/VM
> problem.  There were significant changes to the softirq
> handling between 2.4.5 and 2.4.10, for example.

I don't understand what the softirq is or how that could effect performance.
If you could point me in a direction to look, I'll check that out.
 
> Could I suggest that you split these variables apart?  Perform
> some comparative FS/VM testing between the kernels, and then
> some comparative network testing?

This was on my list of things to do, but I haven't gotten there yet. ;)
Working on it though.

> Is it possible to run the SFS clients on the same machine,
> over loopback?
>

I don't see me getting to this anytime in the near future.  If it will tell
me what I need to know, I'll add it to my to do list.

Cary 
