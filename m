Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317754AbSFMPtD>; Thu, 13 Jun 2002 11:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSFMPtC>; Thu, 13 Jun 2002 11:49:02 -0400
Received: from host194.steeleye.com ([216.33.1.194]:11535 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317754AbSFMPtB>; Thu, 13 Jun 2002 11:49:01 -0400
Message-Id: <200206131548.g5DFmv407602@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andrey Panin <pazke@orbita1.ru>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager 
 (3/4/5xxx series)
In-Reply-To: Message from Andrey Panin <pazke@orbita1.ru> 
   of "Thu, 13 Jun 2002 12:20:53 +0400." <20020613082053.GA614@pazke.ipt> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Jun 2002 11:48:57 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pazke@orbita1.ru said:
> Attached patch is needed to compile kernel with Voyager patch applied
> for the SMP PC machine. 

I've applied it to my repository, thanks.  I forgot to keep track of these 
issues in the voyager tree when I separated the arch-split stuff.

> [Q1] Will it be better to  create separate directory for PC
> architecture and split some PC'isms from arch/i386/generic ? Right now
> it contains acpi.c, bootflag.c and dmi_scan.c which are not generic in
> any way :) 

The thinking currently is that arch/i386 is really PC plus a few exceptions 
rather than a truly generic x86 plus additonal machine architectures, so it 
makes sense under this view that `generic' and PC be the same thing.

> [Q2] May be directory naming like mach-visws, mach-voyager and
> possible  mach-pc will be more convinent ? 

To be more consistent with the way arch/arm does it?  Certainly the renames 
can be done easily enough, what does the rest of the list think?

James


