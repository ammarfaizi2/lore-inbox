Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290896AbSASBNj>; Fri, 18 Jan 2002 20:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290897AbSASBN3>; Fri, 18 Jan 2002 20:13:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11416 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290896AbSASBNP>;
	Fri, 18 Jan 2002 20:13:15 -0500
Date: Fri, 18 Jan 2002 17:11:22 -0800 (PST)
Message-Id: <20020118.171122.123893139.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jamesclv@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Summit interrupt routing patches
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16Rk93-0008SU-00@the-village.bc.nu>
In-Reply-To: <200201190018.g0J0Idq11657@butler1.beaverton.ibm.com>
	<E16Rk93-0008SU-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Sat, 19 Jan 2002 01:18:09 +0000 (GMT)
   
   Im not sure aiming at least important is worth anything. Aiming at idle 
   processors on a box not doing power management seems easy providing you'll
   accept 99.99% accuracy. Switch the priority up in the idle code, switch it
   back down again before the idle task schedule()'s. If you hit during the
   schedule well tough.

$ egrep idle_me_harder arch/sparc64/kernel/process.c
$ egrep "idle_volume|redirect_intr" arch/sparc64/kernel/irq.c

Been there, done that :-)

Franks a lot,
David S. Miller
davem@redhat.com
