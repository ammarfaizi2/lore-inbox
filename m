Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270460AbRHHLtt>; Wed, 8 Aug 2001 07:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270462AbRHHLtj>; Wed, 8 Aug 2001 07:49:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270460AbRHHLta>; Wed, 8 Aug 2001 07:49:30 -0400
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, Release 1 is
To: cate@dplanet.ch
Date: Wed, 8 Aug 2001 12:50:32 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Giacomo Catenazzi" at Aug 08, 2001 01:33:38 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15URr6-00057w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If generating some support files requires some non common tools,
> it is the right thing to ship the two files (source and generated).

Its often easiest. Justin does this with the Adaptec driver now and it makes
life both simple for those who want to build kernels and handy for those
who want to hack the stuff.

> BTW we cannot ship the generated file without the source files,
> because of GPL.

If its part of the kernel tools you want to make it available, that doesn't 
mean it has to be shipped with the kernel. 

Alan
