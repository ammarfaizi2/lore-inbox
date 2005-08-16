Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbVHPSLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVHPSLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbVHPSLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:11:40 -0400
Received: from smtpout.mac.com ([17.250.248.46]:16893 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030276AbVHPSLj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:11:39 -0400
In-Reply-To: <20050814005430.2e26e627@arda.LT-P.net>
References: <E1E13vT-0008G7-R1@arda.LT-P.net> <20050808085703.GE18551@verge.net.au> <20050814005430.2e26e627@arda.LT-P.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <C2F63384-9CC2-4979-956B-8CB5DA77F4AE@mac.com>
Cc: Horms <horms@debian.org>, 321442@bugs.debian.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Bug#321442: kernel-source-2.6.8: fails to compile on powerpc (drivers/ide/ppc/pmac.c)
Date: Tue, 16 Aug 2005 14:11:24 -0400
To: LT-P <LT-P@LT-P.net>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 13, 2005, at 18:54:30, LT-P wrote:
> Le lun 08 aoû 2005 17:57:04 CEST, Horms <horms@debian.org> a écrit:
>> Can you please enable BLK_DEV_IDEDMA_PCI and see if that resolves  
>> your
>> problem. If it does, then the following patch should fix Kconfig
>> so that BLK_DEV_IDEDMA_PCI needs to be enabled for BLK_DEV_IDE_PMAC
>> to be enabled. It should patch cleanly against Debian's 2.6.8 and
>> Linus' current Git tree.
> It seems to solve the problem, thanks.
> Sometimes, I feel like I am the only person in the world to compile  
> the kernel on
> powerpc... :)

Actually, I ran into this same bug a day or so ago when updating to  
2.6.13-rc6,
it's just I noticed the error, fixed my config, then recompiled and  
forgot
about it completely until now :-D.  Thanks for the bug report, though!

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at
it in the right way, did not become still more complicated.
   -- Poul Anderson



