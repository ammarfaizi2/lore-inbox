Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbSAUNVY>; Mon, 21 Jan 2002 08:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286263AbSAUNVO>; Mon, 21 Jan 2002 08:21:14 -0500
Received: from mail2.infineon.com ([192.35.17.230]:2959 "EHLO
	mail2.infineon.com") by vger.kernel.org with ESMTP
	id <S286179AbSAUNVG>; Mon, 21 Jan 2002 08:21:06 -0500
X-Envelope-Sender-Is: Erez.Doron@savan.com (at relayer mail2.infineon.com)
Subject: non volatile ram disk
From: Erez Doron <erez@savan.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Jan 2002 15:15:28 +0200
Message-Id: <1011618928.2825.5.camel@hal.savan.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I'm looking for a way to make a ramdisk which is not erased on reboot
this is for use with ipaq/linux.

i tought of booting with mem=32m and map a block device to the rest of
the 32M ram i have.

the probelm is that giving mem=32m to the kernel will cause the kernel
to map only the first 32m of physical memory to virtual one, so using
__pa(ptr) on the top 32m causes a kernel oops.

any idea ?


regards
erez.

