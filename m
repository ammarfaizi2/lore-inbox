Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281594AbRKMKnr>; Tue, 13 Nov 2001 05:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281597AbRKMKnh>; Tue, 13 Nov 2001 05:43:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13701 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281594AbRKMKn0>;
	Tue, 13 Nov 2001 05:43:26 -0500
Date: Tue, 13 Nov 2001 02:43:14 -0800 (PST)
Message-Id: <20011113.024314.11053028.davem@redhat.com>
To: kaos@ocs.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, girouard@us.ibm.com,
        indou.takao@jp.fujitsu.com, ctindel@ieee.org, mhuth@mvista.com
Subject: Re: Linux 2.4.15-pre4 - merge with Alan 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <12029.1005628638@kao2.melbourne.sgi.com>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
	<12029.1005628638@kao2.melbourne.sgi.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Tue, 13 Nov 2001 16:17:18 +1100

   drivers/net/bonding.c has #include <limits.h>, exposing the kernel to
   user space dependencies.  It must be removed.
   
   I could not find a maintainer for this beast so cc'ed to seevral users
   in the changelog.
   
Documentation/networking/bonding.txt says:

Current developement on this driver is posted to:
 - http://www.sourceforge.net/projects/bonding/

But I've made the fix and sent it off to Linus for you :)

Franks a lot,
David S. Miller
davem@redhat.com
