Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133113AbRDVCBW>; Sat, 21 Apr 2001 22:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133114AbRDVCBL>; Sat, 21 Apr 2001 22:01:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6414 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133113AbRDVCA6>; Sat, 21 Apr 2001 22:00:58 -0400
Subject: Re: 2.4.3-ac10/ac11 crash at boot in PDC20265 check
To: manuel@mclure.org (Manuel McLure)
Date: Sun, 22 Apr 2001 03:02:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010421183212.G1106@ulthar.internal.mclure.org> from "Manuel McLure" at Apr 21, 2001 06:32:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14r9Ck-0004nW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Found promise 20265 in RAID mode." message. I diffed ide-pci.c between ac5
> (which worked) and ac10 (which fails) and found that the only change was
> the check for the PDC20265 - I commented this out and the kernel boots fine
> now.

Can you send me the oops data. I'll take a look and figure out what is up.
My first guess would be its a NULL pointer error ?

