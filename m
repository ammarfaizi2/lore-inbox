Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132835AbRDUTLd>; Sat, 21 Apr 2001 15:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132832AbRDUTLY>; Sat, 21 Apr 2001 15:11:24 -0400
Received: from frank.gwc.org.uk ([212.240.16.7]:4109 "EHLO frank.gwc.org.uk")
	by vger.kernel.org with ESMTP id <S132831AbRDUTLK>;
	Sat, 21 Apr 2001 15:11:10 -0400
Date: Sat, 21 Apr 2001 20:11:07 +0100 (BST)
From: Alistair Riddell <ali@gwc.org.uk>
To: Tamas Nagy <nagytam@rerecognition.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Idea: Encryption plugin architecture for file-systems
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com>
Message-ID: <Pine.LNX.4.21.0104212009350.3571-100000@frank.gwc.org.uk>
X-foo: bar
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried:

man losetup

losetup /dev/loop0 /dev/hdxx -e DES
mke2fs /dev/loop0
mount /dev/loop0 /mnt/


On Sat, 21 Apr 2001, Tamas Nagy wrote:

> Hello,
> 
> Lot of people would like to know their data in secure place, and the
> frequent usage of compression softwares could be time-consuming and boring
> sometime.
> 
> Idea:
> extend the current file-system with an optional plug-in system, which allows
> for file-system level encryption instead of file-level. This could be used
> transparently for applications or even for file-system drivers.  This
> doesn't mean an encrypted file-system, but a transparent encryption of a
> media instead.
> 
> Advantages:
> #1: optional security level for every data, without user interaction.
> #2: if this idea is used e.g. for portable media (like cdrom), your backup
> could be in safe also.
> #3: (almost;)) everybody could create own security plugin for their data,
> and not have to trust on the designers of a secure file systems.
> 
> I suspect that this idea may appeared in the past:(, but I haven't heard
> about it;).
> 
> So, what do you think about this? Is Linux kernel enough flexible to do
> this? What changes are necessary to do such a thing? Is there any other way,
> to have own security for file-systems or portable medias? Is this
> implementation could be used in the US?
> 
> Best regards,
> Tamas Nagy
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Alistair Riddell - BOFH
IT Support Department, George Watson's College, Edinburgh
Tel: +44 131 447 7931 Ext 176       Fax: +44 131 452 8594
Microsoft - because god hates us

