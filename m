Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272688AbRHaNtu>; Fri, 31 Aug 2001 09:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272689AbRHaNtj>; Fri, 31 Aug 2001 09:49:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62472 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272688AbRHaNt2>; Fri, 31 Aug 2001 09:49:28 -0400
Subject: Re: Messages "ACPI attempting to access kernel owned memory"?
To: afranck@gmx.de (Andreas Franck)
Date: Fri, 31 Aug 2001 14:53:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <01083103560000.00925@dg1kfa> from "Andreas Franck" at Aug 31, 2001 03:56:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cojW-0003B7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, your code is all right, I have found the cause of this behaviour: it's 
> because I boot with GRUB and not with LILO. So, you might say "What the hell 
> does the bootloader matter", and this is what I also thought in the first 
> hours, until I noticed that GRUB was adding a "mem=524288K" entry to my 

This is a known problem with old versions of GRUB. Up to date versions of
grub shouldnt be passing mem= lines.

Alan
