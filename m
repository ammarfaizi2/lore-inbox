Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281488AbRKMFRx>; Tue, 13 Nov 2001 00:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281503AbRKMFRe>; Tue, 13 Nov 2001 00:17:34 -0500
Received: from rj.sgi.com ([204.94.215.100]:64996 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281499AbRKMFR3>;
	Tue, 13 Nov 2001 00:17:29 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Janice Girouard <girouard@us.ibm.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>,
        "Chad N. Tindel" <ctindel@ieee.org>, Mark Huth <mhuth@mvista.com>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan 
In-Reply-To: Your message of "Mon, 12 Nov 2001 11:01:56 -0800."
             <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 16:17:18 +1100
Message-ID: <12029.1005628638@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/bonding.c has #include <limits.h>, exposing the kernel to
user space dependencies.  It must be removed.

I could not find a maintainer for this beast so cc'ed to seevral users
in the changelog.

