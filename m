Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbSLLV4a>; Thu, 12 Dec 2002 16:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267501AbSLLV4a>; Thu, 12 Dec 2002 16:56:30 -0500
Received: from smtp-03.inode.at ([62.99.194.5]:1415 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S267491AbSLLV4a> convert rfc822-to-8bit;
	Thu, 12 Dec 2002 16:56:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Patrick Petermair <black666@inode.at>
Reply-To: black666@inode.at
To: Brendon Higgins <bh_doc@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: dvd-drive no longer works (2.4.20)
Date: Thu, 12 Dec 2002 23:05:32 +0100
User-Agent: KMail/1.4.3
References: <200212051151.59330.bh_doc@users.sourceforge.net>
In-Reply-To: <200212051151.59330.bh_doc@users.sourceforge.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212122305.32825.black666@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Dezember 2002 02:51 schrieb Brendon Higgins:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hello. I have a problem since upgrading linux from 2.4.19 to 2.4.20.
> During boot, the kernel spits out several "status error" and other
> messages about my dvd and cdrw drives (both on ide1).
>
> I upgraded from 2.4.19 to 2.4.20 in the hope that DMA would finally
> work with my vt8235 (MSI KT3 Ultra2 with VIA KT333). 

Same here. I also have a MSI KT3 Ultra2 and the same problem with 2.4.20

The -ac1 patch helped because it booted just fine and I had dma on my 
harddisk. But then I had problems mounting my dvd drive ... I'll try 
the new -ac2 patch today, let's see if it makes any difference.

Btw: I think it depends what cd/dvd drive you have. I've heard from 
other people with MSI KT3 Ultra2 who have no problem with 2.4.20 
(without ac1 patch) and dma on disks plus dvd/cd/cdrw.

Patrick



