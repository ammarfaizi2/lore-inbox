Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRKHSOp>; Thu, 8 Nov 2001 13:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277431AbRKHSOg>; Thu, 8 Nov 2001 13:14:36 -0500
Received: from full199.sara.unitn.it ([193.205.210.199]:13556 "EHLO
	dizzy.dz.net") by vger.kernel.org with ESMTP id <S277380AbRKHSOW>;
	Thu, 8 Nov 2001 13:14:22 -0500
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200111081814.fA8IE4qi003266@dizzy.dz.net>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
In-Reply-To: "from (env: dz) at Nov 7, 2001 03:21:44 pm"
To: Linux Kernel <linux-kernel@vger.kernel.org>
Date: Thu, 8 Nov 2001 19:14:03 +0100 (MET)
CC: stephane@tuxfinder.org
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have released version 1.4 of my package with a new kernel module and
some enhancements to the i8kmon utility.

It should now work on more Dell laptops (Inspiron and Latitude) and report
correctly the bios version and machine id. If it doesn't load try forcing
it with:

    insmod ./i8k.o force=1

Please test the new version and send me a report. Don't forget to include
the following information:

    laptop model
    bios version
    driver version
    i8kmon version
    kernel messages while loading the driver
    output of "cat /proc/i8k"

and a detailed description of any problem you have found.

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: massimo.dalzotto@libero.it   |
|  Via Marconi, 141                phone: ++39-461534251               |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                                  http://www.debian.org/~dz/   |
|  gpg:   2DB65596  3CED BDC6 4F23 BEDA F489 2445 147F 1AEA 2DB6 5596  |
+----------------------------------------------------------------------+
