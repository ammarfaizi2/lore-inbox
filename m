Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280018AbRKDPys>; Sun, 4 Nov 2001 10:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280017AbRKDPyj>; Sun, 4 Nov 2001 10:54:39 -0500
Received: from mail024.mail.bellsouth.net ([205.152.58.64]:22729 "EHLO
	imf24bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280014AbRKDPyW>; Sun, 4 Nov 2001 10:54:22 -0500
Message-ID: <3BE564A4.D88D1951@mandrakesoft.com>
Date: Sun, 04 Nov 2001 10:54:12 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
CC: Linux <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: SYM-2 patches against latest kernels available
In-Reply-To: <20011104133028.M1354-100000@gerard>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> The patch against linux-2.4.13 has been sent to Alan Cox for inclusion in
> newer stable kernels. Alan wants to test it on his machines which is a
> good thing. Anyway, those patches just add the new driver version to
> kernel tree and leave stock sym53c8xx and ncr53c8xx in place.

Are the older sym/ncr drivers going away in 2.5?


> Any report, especially on large memory machines using 64 bit DMA (2.4
> kernels + PCI DAC capable controllers only), is welcome. I can't test 64
> bit DMA, since my fatest machine has only 512 MB of memory.
> 
> To configure the driver, you must select "SYM53C8XX version 2 driver" from
> kernel config. For large memory machines, a new "DMA addressing mode"
> option is to be configured as follows (help texts have been added to
> Configure.help):
> 
> Value 0: 32 bit DMA addressing
> Value 1: 40 bit DMA addressing (upper 24 bytes set to zero)
> Value 2: 64 bit DMA addressing limited to 16 segments of 4 GB (64 GB) max.

Are you using the new pci64 API under 2.4.x?

Thanks,

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

