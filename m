Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136464AbREIOCf>; Wed, 9 May 2001 10:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136465AbREIOCZ>; Wed, 9 May 2001 10:02:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3850 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136464AbREIOCJ>; Wed, 9 May 2001 10:02:09 -0400
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
To: bennyb@ntplx.net (Benedict Bridgwater)
Date: Wed, 9 May 2001 15:06:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3AF93F2B.8EC5F912@ntplx.net> from "Benedict Bridgwater" at May 09, 2001 08:59:23 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xUbS-0002Op-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This has been reported to both Mandrake and Redhat:
> 
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=29555
> 
> I've been trying to find out if there's a fix (if it's aic7xxx 6.1.13
> that's great!), but Redhat seem to believe it's a 2.4 kernel PCI bug:

Personally I still think its a BIOS bug in those Intel BIOS boards. Hopefully
some of the VA folks will eventually have time to double check the BIOS
$PIRQ routing table on these systems and verify if the kernel is parsing it
wrong or if its wrong in the BIOS ROM

