Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318807AbSIISUa>; Mon, 9 Sep 2002 14:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318809AbSIISUa>; Mon, 9 Sep 2002 14:20:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2978 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318807AbSIISU1>;
	Mon, 9 Sep 2002 14:20:27 -0400
Date: Mon, 09 Sep 2002 11:17:07 -0700 (PDT)
Message-Id: <20020909.111707.29334607.davem@redhat.com>
To: root@chaos.analogic.com
Cc: imran.badr@cavium.com, phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com>
References: <019f01c25826$c553f310$9e10a8c0@IMRANPC>
	<Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Richard B. Johnson" <root@chaos.analogic.com>
   Date: Mon, 9 Sep 2002 14:00:35 -0400 (EDT)

   Well I just read Documentation/DMA-mapping.txt as advised by David
   and it seems as though it will no longer be possible to do what
   many programmers have been wanting to do, to wit:
   
   (1) In user-code, allocate a buffer.
   (2) Lock that buffer into memory.
   (3) Call some driver that DMAs data to/from that buffer.
   
Video capture drivers and ALSA layer in 2.5.x kernel do
this perfectly fine.  Perhaps you should have a look
at how they handle DMA on PCI.
