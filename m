Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290863AbSARXF6>; Fri, 18 Jan 2002 18:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290867AbSARXFs>; Fri, 18 Jan 2002 18:05:48 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:53888 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S290863AbSARXFf>; Fri, 18 Jan 2002 18:05:35 -0500
To: bgerst@didntduck.org, raul@viadomus.com
Subject: Re: Is there anyway to use 4M pages on x86 linux in user level?
Cc: linux-kernel@vger.kernel.org, yinlei_yu@hotmail.com
Message-Id: <E16RiH9-0007mc-00@DervishD.viadomus.com>
Date: Sat, 19 Jan 2002 00:18:23 +0100
From: DervishD <raul@viadomus.com>
Reply-To: DervishD <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello Brian :)

>>     The entries in the GDT, do not set the page size for that
>> descriptor? I'm certainly rusted on the i386 O:)))
>No, there is a bit in the page directory that determines if the entry
>points to a page table (with 4KB pages) or to a 4MB page.  The GDT is
>only used for segmentation, which is totally seperate from paging.

    That was my confusion: I forgot that the i386 does segmentation
AND paging. Thanks for the help :) I've taking a look at a book that
I had gathering dust (maybe 8 years...), by Douglas V.Hall. I must
take a really *deep* read into it and other i386 documentation before
getting in this kind of conversations O:)). Thanks again for your help.

    Raúl
