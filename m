Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbSK2OAU>; Fri, 29 Nov 2002 09:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267047AbSK2OAU>; Fri, 29 Nov 2002 09:00:20 -0500
Received: from mail.hamburg.pop.de ([193.98.9.7]:8876 "EHLO mail.provi.de")
	by vger.kernel.org with ESMTP id <S267043AbSK2OAT>;
	Fri, 29 Nov 2002 09:00:19 -0500
Message-Id: <3DE774AC.6E371602@gmx.de>
Date: Fri, 29 Nov 2002 15:07:40 +0100
From: Bernd Harries <bha@gmx.de>
Reply-To: bha@gmx.de
Organization: STN ATLAS Elektronik GmbH
X-Mailer: Mozilla 4.72 [en] (X11; I; OSF1 V4.0 alpha)
X-Accept-Language: en
Mime-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ioremap returns NULL
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

my normally (on 256 MB, dual Xeon, ASUS board, .....) working driver
module fails on a new box with 1 MB RAM, 2 PIII, ASUS board

For each card I ioremap() 2 * 16 MB of PCI memory space.
It succeeds for the 1st card but for the 2nd card I get NULL
as result. This means I cannot use the 2nd card...

Is the reason for this that the RAM is bigger? 
What could I do about it? 
- Build a 64 GB kernel? 
- Use an other function?
- pull out sone DIMM?
- nothing?

Thanks,  Bernd

-- 
Bernd Harries

bha@gmx.de
bharries@web.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org       +49 172 139 6054 handy  | Medusa T40
