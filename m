Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270462AbRHHLz7>; Wed, 8 Aug 2001 07:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270464AbRHHLzt>; Wed, 8 Aug 2001 07:55:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4104 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270462AbRHHLzl>; Wed, 8 Aug 2001 07:55:41 -0400
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, Release 1 is available.
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 8 Aug 2001 12:56:59 +0100 (BST)
Cc: cate@dplanet.ch, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <1556.997271459@ocs3.ocs-net> from "Keith Owens" at Aug 08, 2001 09:50:59 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15URxL-00058f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Absolutely agree.  But we have files in the tar ball that are generated
> using standard tools.
> 
> net/802/pseudo/pseudocode.h is shipped, but it is generated using sed.
> net/802/pseudo/actionnm.h is shipped, it is generated using sed,
> nothing even uses the file.
> net/802/transit/pdutr.h and timertr.h are shipped but they are
> generated using awk.
> net/802/cl2llc.c is shipped but it is generated using sed.
> 
> I will remove all of those from the tar ball.

Please don't. net/802 is being rewritten and you'll just cause noise

Alan
