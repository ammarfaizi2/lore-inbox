Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293448AbSCABKj>; Thu, 28 Feb 2002 20:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310159AbSCABHT>; Thu, 28 Feb 2002 20:07:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56960 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310275AbSCABFe>;
	Thu, 28 Feb 2002 20:05:34 -0500
Date: Thu, 28 Feb 2002 17:03:17 -0800 (PST)
Message-Id: <20020228.170317.70477069.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: rui.p.m.sousa@clix.pt, german@piraos.com, jcm@netcabo.pt,
        linux-kernel@vger.kernel.org, emu10k1-devel@lists.sourceforge.net,
        steve@math.upatras.gr, d.bertrand@ieee.org, dledford@redhat.com
Subject: Re: [Emu10k1-devel] Re: Emu10k1 SPDIF passthru doesn't work if
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16gbWB-0001rm-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.44.0202282042150.1215-100000@sophia-sousar2.nice.mindspeed.com>
	<E16gbWB-0001rm-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Fri, 1 Mar 2002 01:07:27 +0000 (GMT)
   
   The cast befor ethe cpu_to_ is safe if its 32bit I/O only. Maybe we should
   have cpu_to_le_dma_addr_t 8)

Actually, the cast to 32-bit is safe if you've set your DMA mask
properly :-)
