Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314523AbSDXFAn>; Wed, 24 Apr 2002 01:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311650AbSDXFAm>; Wed, 24 Apr 2002 01:00:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25353 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314523AbSDXFAl>; Wed, 24 Apr 2002 01:00:41 -0400
Subject: Re: Kernel oops and drive failure
To: carville@cpl.net (Stephen Carville)
Date: Wed, 24 Apr 2002 06:19:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <Pine.LNX.4.33.0204212029200.2467-100000@warlock.heronforge.net> from "Stephen Carville" at Apr 21, 2002 08:31:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E170FBH-0001rI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Apr 21 18:09:54 jordan kernel:  I/O error: dev 08:41, sector 98566248
> Apr 21 18:09:54 jordan kernel: raid5: Disk failure on sde1, disabling
> device. Operation continuing on 3 devices
> 

The raid array took a drive failure and started recovery

> Apr 21 18:09:54 jordan kernel: md: recovery thread got woken up ...
> Apr 21 18:09:54 jordan kernel: Unable to handle ke<1lUaULLblepto
> tandde kfeeencernel NULL pointer dereference<6>md: recovery thread
> finished ...

Things then went a bit pear shaped - the rest is an oops and wants 
decoding (see REPORTING-BUGS)
