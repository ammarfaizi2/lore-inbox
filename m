Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRKMQ0c>; Tue, 13 Nov 2001 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRKMQ0W>; Tue, 13 Nov 2001 11:26:22 -0500
Received: from palrel13.hp.com ([156.153.255.238]:2062 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S274248AbRKMQ0I>;
	Tue, 13 Nov 2001 11:26:08 -0500
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
From: "Chad N. Tindel" <ctindel@cup.hp.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Janice Girouard <girouard@us.ibm.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>,
        "Chad N. Tindel" <ctindel@ieee.org>, Mark Huth <mhuth@mvista.com>
In-Reply-To: <12029.1005628638@kao2.melbourne.sgi.com>
In-Reply-To: <12029.1005628638@kao2.melbourne.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 13 Nov 2001 09:27:08 -0800
Message-Id: <1005672430.1361.2.camel@ct742302.cup.hp.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/net/bonding.c has #include <limits.h>, exposing the kernel to
> user space dependencies.  It must be removed.
> 
> I could not find a maintainer for this beast so cc'ed to seevral users
> in the changelog.

Thanks for the message.  I just noticed that the bonding patch had been
included in 2.4.15-pre3.  I hadn't realized Alan was going to integrate
it yet!  I'm happy he did though.  I have a patch which addresses that
issue and some race conditions which I'll send out immediately.

Chad

-- 
Chad N. Tindel <ctindel@cup.hp.com>
Software Engineer
Hewlett Packard, Cupertino
(408) 447-4230

