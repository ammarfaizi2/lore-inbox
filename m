Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310159AbSCKPTx>; Mon, 11 Mar 2002 10:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310154AbSCKPTn>; Mon, 11 Mar 2002 10:19:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15882 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310151AbSCKPT0>; Mon, 11 Mar 2002 10:19:26 -0500
Subject: Re: 2.4.19pre2aa2
To: andrea@suse.de (Andrea Arcangeli)
Date: Mon, 11 Mar 2002 15:34:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020311082031.B10413@dualathlon.random> from "Andrea Arcangeli" at Mar 11, 2002 08:20:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kRp6-0000rR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only in 2.4.19pre2aa2: 00_amd-viper-7441-guessed-1
> 
> 	Let amd74xx recognize the 7441 amd chipset, it works and I needed it
> 	mainly to set ->highmem = 1 and to skip the bounce buffers on my
> 	desktop.  (Tried also mode 5 and it failed, so I #undef __CAN_MODE_5
> 	back)

The correct AMD 7441 fixes are in the IDE patch and have been for a few
months. They were supplied by AMD and work a treat. I don't believe there is
any reason they require the new IDE infrastructure. They are howeve 32bit
still so the 64bit IDE will be nice
