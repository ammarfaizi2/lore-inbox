Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSEUTX6>; Tue, 21 May 2002 15:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSEUTX5>; Tue, 21 May 2002 15:23:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37383 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315454AbSEUTX5>; Tue, 21 May 2002 15:23:57 -0400
Subject: Re: Asus a7m266d stability issues
To: dimperio@physics.dyndns.org (Nicholas L. D'Imperio)
Date: Tue, 21 May 2002 19:47:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205211413310.515-100000@physics.dyndns.org> from "Nicholas L. D'Imperio" at May 21, 2002 02:20:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AEf7-0008NO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm getting kernel panics using the A7m266d smp motherboard and kernel 
> 2.4.18 as soon as the system is put under load.

Mine is rock solid with dual processors.

> It's rock solid when booted using uni-processor kernel.

Did you use XP or MP processors. Do you have at least a 400W PSU ?

> Also, hdparm reports the drive as udma2 even though it's udma5.  
> IDE performance as measured by hdparm is terribly slow even when compared 
> to what it should be using udma2.

AMD76x IDE is a new feature in 2.4.19pre. That supports UDMA100


Alan
