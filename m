Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135504AbREAMy3>; Tue, 1 May 2001 08:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135767AbREAMyT>; Tue, 1 May 2001 08:54:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40968 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135504AbREAMyB>; Tue, 1 May 2001 08:54:01 -0400
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
To: bergsoft@home.com (Seth Goldberg)
Date: Tue, 1 May 2001 13:57:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AEE9491.D0C4C366@home.com> from "Seth Goldberg" at May 01, 2001 03:48:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uZj4-0001bF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>       when I add USE_3DNOW to the K6 section and reboot, KDE hangs when
>       I click on any button in my launch bar (vanilla KDE 2.0).  It
>       does NOT hang the system, though.  Restarting Xwindows does not
> help,

The K6 USE_3DNOW has two problems

1.	It doesnt work on a CPU with fxsave (my bug and its fixed in -ac)
2.	Its not a performance win. 

#2 doesn't matter for testing

>   [3] When I add 3DNOW to any option in [2] w/ the Athlon MMX opt,
>       the instability is evident after root is mounted and startup
>       scripts begin executing.  Sometimes the system can make it through
>       other times it cannot.

And I still have no problem reporters with non VIA chipsets....

Alan

