Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSFFXsX>; Thu, 6 Jun 2002 19:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSFFXsW>; Thu, 6 Jun 2002 19:48:22 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17172 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313202AbSFFXsV>; Thu, 6 Jun 2002 19:48:21 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200206062347.g56NlwZ17861@devserv.devel.redhat.com>
Subject: Re: [PATCH] update for ALi Audio Driver (0.14.10)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 6 Jun 2002 19:47:58 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lei_hu@ali.com.tw, alan@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CFFA55F.8000008@mandrakesoft.com> from "Jeff Garzik" at Jun 06, 2002 02:09:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why?  Hardware semaphores are notorious for causing hangs.  Nobody is 
> sharing the hardware under Linux, so I think we should enable access on 
> init, and not disable access until driver close.  IMO the mixer should 
> be guarded by a Linux kernel semaphore...  I have a patch from Thomas 
> Sailer (I think) lying around somewhere that does just that to the via 
> audio driver.  Maybe we can adapt it.
> (I cc'd this little detail, in my ali/trident.c patch review, to you)

So add a timeout to it ?
