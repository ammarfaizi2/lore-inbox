Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSLaOin>; Tue, 31 Dec 2002 09:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSLaOin>; Tue, 31 Dec 2002 09:38:43 -0500
Received: from smtp.inet.fi ([192.89.123.192]:17402 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id <S262859AbSLaOim>;
	Tue, 31 Dec 2002 09:38:42 -0500
Message-ID: <3E11ADAD.4A0DDCC0@softers.net>
Date: Tue, 31 Dec 2002 16:46:05 +0200
From: Jarmo =?iso-8859-1?Q?J=E4rvenp=E4=E4?= 
	<Jarmo.Jarvenpaa@softers.net>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Athanasius <link@gurus.tf>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 lockups - IDE ?
References: <20021227010612.GD10426@miggy.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be same kind of a problem I'm having.

I noticed you're not using sw-raid nor the HPT366-driver (which I
suspected). I also tried disabling the IRQ sharing from the ide devices,
changed ide disks to be masters on their own bus and used hdparm on
disks to have very basic configuration options but no success on
eliminating the fault.


Regards,
Jarmo


My motherboard is the same / at least with the same chipset.

Athanasius wrote:
> 
> Hi,
>   I've twice now experienced more or less solid lockups of 2.4.20, once
> with vanilla, the second time with Andrew Morton's ext3 patches from:
