Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSEMMXT>; Mon, 13 May 2002 08:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSEMMXR>; Mon, 13 May 2002 08:23:17 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:20870 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313190AbSEMMXR>; Mon, 13 May 2002 08:23:17 -0400
Date: Mon, 13 May 2002 14:23:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Diego Calleja <DiegoCG@teleline.es>
cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_ISA
In-Reply-To: <20020512225724.232357b3.DiegoCG@teleline.es>
Message-ID: <Pine.GSO.3.96.1020513141909.26083B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Diego Calleja wrote:

> Sorry for my ignorance, but the typical conectors: mouse, keyboard,
> /dev/ttyS0, /dev/ttyS1, /dev/lp0...aren't isa devices? 

 The PS/2 mouse and the keyboard (or the 8042, actually) are motherboard
devices using the 0x00-0xff range of I/O ports -- ISA is above that.

 For serial and parallel ports it depends on their configuration. 
Traditionally they are ISA devices, but PCI variations are manufactured
these days as well. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

