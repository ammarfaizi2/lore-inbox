Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293008AbSCJKMC>; Sun, 10 Mar 2002 05:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293010AbSCJKLn>; Sun, 10 Mar 2002 05:11:43 -0500
Received: from 1Cust48.tnt6.lax7.da.uu.net ([67.193.244.48]:52462 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S293008AbSCJKLl>; Sun, 10 Mar 2002 05:11:41 -0500
Subject: Re: Suspend support for IDE
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 9 Mar 2002 16:52:13 -0800 (PST)
Cc: pavel@ucw.cz (Pavel Machek), alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <E16joxm-0002g6-00@the-village.bc.nu> from "Alan Cox" at Mar 09, 2002 10:05:14 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020310005213.1D8BB8959A@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why should I tell the drive to power down? It is going to loose its
> > power, anyway (I believe in both S3 and S4).
> 
> So it can shut itself down nicely and do any housework it wants to do
> (like flushing the cache if the cache flush command isnt supported.. its
>  optional in older ATA standards)

Or, in the case of newer IBM TravelStars, so that the drive can unload
its head properly instead of having to do an uncontrolled emergency unload
that shortens the drive's life and makes an awful screeching noise.

-Barry K. Nathan <barryn@pobox.com>
