Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280059AbRLLOD1>; Wed, 12 Dec 2001 09:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280114AbRLLODR>; Wed, 12 Dec 2001 09:03:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10765 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280059AbRLLODG>; Wed, 12 Dec 2001 09:03:06 -0500
Subject: Re: Kernel issue 2.4.6~2.4.16
To: aaronhsieh@msi.com.tw
Date: Wed, 12 Dec 2001 14:12:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org,
        mollywu@msi.com.tw (=?big5?B?TW9sbHlXdSinZKlzxFIp?=)
In-Reply-To: <000e01c182b7$ea5d65a0$1c0510ac@ah> from "aaronhsieh" at Dec 12, 2001 10:50:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16EA7l-0001EY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generally speaking if you have an AMD Athlon based board that will run with
a Pentium II/III kernel but not and Athlon optimised kernel you have a
hardware flaw, or misprogrammed chipset.

Some BIOSes misconfigure the VIA chipsets at least, and that causes this 
problem when we run the memory bus flat out with the athlon optimised 
prefetching memory copies

Alan
