Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSHGQGW>; Wed, 7 Aug 2002 12:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318398AbSHGQGW>; Wed, 7 Aug 2002 12:06:22 -0400
Received: from jalon.able.es ([212.97.163.2]:7552 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317829AbSHGQGV>;
	Wed, 7 Aug 2002 12:06:21 -0400
Date: Wed, 7 Aug 2002 18:08:43 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: AGP aperture for SiS
Message-ID: <20020807160843.GA2697@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I have a laptop with a SiS630 chipset. Its VGA stoles memory from main RAM
to act as video RAM (that damned shared ram invention...). It is an AGP
vga, and agpgart always report AGP aperture as 64Mb, independently of how
much memory I have assigned for VGA in the bios. I always undestood that
aperture should be about 2x the card memory (even still I have not clear
what is aperture for...any pointer ?).

How can I tell agpgart that I only want, say, 8Mb for agp aperture ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre1-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-0.2mdk))
