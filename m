Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbRE2UUN>; Tue, 29 May 2001 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbRE2UTx>; Tue, 29 May 2001 16:19:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62476 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261786AbRE2UTn>; Tue, 29 May 2001 16:19:43 -0400
Subject: Re: Plain 2.4.5 VM... (and 2.4.5-ac3)
To: linuxkernel@AdvancedResearch.org (Vincent Stemen)
Date: Tue, 29 May 2001 21:16:59 +0100 (BST)
Cc: elko@home.nl (elko), linux-kernel@vger.kernel.org,
        jq419@my-deja.com (Jacky Liu)
In-Reply-To: <01052915095400.32108@quark> from "Vincent Stemen" at May 29, 2001 03:09:54 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154pvH-0004q1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a reasonably stable release until 2.2.12.  I do not understand why
> code with such serious reproducible problems is being introduced into
> the even numbered kernels.  What happened to the plan to use only the

Who said it was introduced ?? It was more 'lurking' than introduced. And 
unfortunately nobody really pinned it down in 2.4test.

> By the way,  The 2.4.5-ac3 kernel still fills swap and runs out of
> memory during my morning NFS incremental backup.  I got this message
> in the syslog.

2.4.5-ac doesn't do some of the write throttling. Thats one thing I'm still
working out. Linus 2.4.5 does write throttling but Im not convinced its done
the right way

> completely full.  By that time the memory was in a reasonable state
> but the swap space is still never being released.

It wont be, its copied of memory already in apps. Linus said 2.4.0 would need
more swap than ram when he put out 2.4.0.


Alan

