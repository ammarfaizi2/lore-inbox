Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290722AbSBFSQv>; Wed, 6 Feb 2002 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290728AbSBFSQl>; Wed, 6 Feb 2002 13:16:41 -0500
Received: from ns.caldera.de ([212.34.180.1]:65426 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S290722AbSBFSQc>;
	Wed, 6 Feb 2002 13:16:32 -0500
Date: Wed, 6 Feb 2002 18:20:46 +0100
Message-Id: <200202061720.g16HKk812411@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Cc: aia21@cam.ac.uk (Anton Altaparmakov),
        linux-kernel@vger.kernel.org (linux-kernel),
        vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: kernel: ldt allocation failed
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <E16YSLg-00056Z-00@the-village.bc.nu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16YSLg-00056Z-00@the-village.bc.nu> you wrote:
>> I am ignorant on the subject, but why LDT is used in Linux at all?
>> LDT register can be set to 0, this can speed up task switch time and save 
>> some memory used for LDT.
>
> Wine and certain threaded applications

Xenix/286 binary emulation.

