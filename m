Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSDZQPC>; Fri, 26 Apr 2002 12:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSDZQPB>; Fri, 26 Apr 2002 12:15:01 -0400
Received: from saltbush.adelaide.edu.au ([129.127.43.5]:42984 "EHLO
	saltbush.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S314077AbSDZQPA>; Fri, 26 Apr 2002 12:15:00 -0400
From: "Hong-Gunn Chew" <hgchewML@optusnet.com.au>
To: "'Petr Vandrovec'" <VANDROVE@vc.cvut.cz>
Cc: "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
        <riel@conectiva.com.br>
Subject: RE: File corruption when running VMware.
Date: Sat, 27 Apr 2002 01:44:44 +0930
Message-ID: <000b01c1ed3d$7b87a640$1405a8c0@hgclaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <37A7BD60863@vcnet.vc.cvut.cz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

> Hi again,
>   one of 2.4.x kernel images available in SuSE's 8.0 has 
> patched&enabled 
> support for page tables in high memory, and this quickly 
> revealed incompatibility between VMware's vmmon page table 
> handling and ptes above directly mapped range.
> 
>   So if you have >890MB of RAM and your kernel is compiled 
> with support for pte in high memory, please stop using 
> VMware, or reconfigure your 
> kernel to not use pte in high memory (4GB config without 
> pte-in-highmem is OK). Using pte-in-highmem with vmmon will 
> cause kernel oopses and/or 
> memory corruption :-(

I do have 1GB of memory.  I will try to reconfigure my kernel
and see if there's still a problem.
Thanks for the info!

Cheers,
Hong-Gunn

