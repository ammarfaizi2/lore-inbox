Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269735AbRHMCfV>; Sun, 12 Aug 2001 22:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269740AbRHMCfL>; Sun, 12 Aug 2001 22:35:11 -0400
Received: from 66-44-11-187.s441.apx2.lnh.md.dialup.rcn.com ([66.44.11.187]:56961
	"HELO Grimlock.cybertron.lan") by vger.kernel.org with SMTP
	id <S269735AbRHMCe6>; Sun, 12 Aug 2001 22:34:58 -0400
Date: Sun, 12 Aug 2001 22:35:07 -0400 (EDT)
From: Kryten <magik@erols.com>
X-X-Sender: <kryten@Trypticon.cybertron.lan>
Reply-To: Kryten <magik@erols.com>
To: Frank Jacobberger <f1j@xmission.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 5
In-Reply-To: <3B77361B.6020302@xmission.com>
Message-ID: <Pine.LNX.4.31.0108122227240.3501-100000@Trypticon.cybertron.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001, Frank Jacobberger wrote:

> Where is kernel development with respect to ATA 100
> IDE drives? The only param idebus=xx takes is 66... are
> there plans to go to 100?
>
> Running 2.4.8 here
>
> Frank

Yikes! idebus is for specifying the PCI bus speed. That should be "33" for
most systems unless it's overclocked. It has nothing to do with UDMA.
ATA100 support has been in the kernel for some time. Just select Use DMA
in the kernel config and select the proper motherboard chipset and you
should be fine.



---------------------
This message powered
by Pine and GNU/Linux


