Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288851AbSBMUSh>; Wed, 13 Feb 2002 15:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288854AbSBMUSR>; Wed, 13 Feb 2002 15:18:17 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:15376 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id <S288851AbSBMUSJ>;
	Wed, 13 Feb 2002 15:18:09 -0500
Message-Id: <200202132133.g1DLXPL27236@clueserver.org>
Content-Type: text/plain; charset=US-ASCII
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, davem@redhat.com (David S. Miller)
Subject: Re: 2.5.4 sound module problem
Date: Wed, 13 Feb 2002 10:59:25 -0800
X-Mailer: KMail [version 1.3.1]
Cc: alan@lxorguk.ukuu.org.uk, ac9410@bellsouth.net, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16awaG-0004sB-00@the-village.bc.nu>
In-Reply-To: <E16awaG-0004sB-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 February 2002 02:24, Alan Cox wrote:
> >    There are PCI drivers using the old sound code. Whether it matters is
> > a more complicated question as these devices use ISA DMA emulation or
> > their own pseudo DMA functionality.
> >
> > The sound layer PCI DMA stuff like a nice project for some kernel
> > janitors :-))
>
> Waste of effort. ALSA will replace the OSS code anyway

When I looked at the code, it looked like a lot more than just the sound code 
needed to be fixed.  I will look at the next patch and see what is left.
