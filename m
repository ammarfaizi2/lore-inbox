Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSIIR1C>; Mon, 9 Sep 2002 13:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSIIR1C>; Mon, 9 Sep 2002 13:27:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37025 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317592AbSIIR1C>;
	Mon, 9 Sep 2002 13:27:02 -0400
Date: Mon, 09 Sep 2002 10:23:41 -0700 (PDT)
Message-Id: <20020909.102341.29032821.davem@redhat.com>
To: root@chaos.analogic.com
Cc: imran.badr@cavium.com, phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1020909132344.17307A-100000@chaos.analogic.com>
References: <019d01c25823$8714c460$9e10a8c0@IMRANPC>
	<Pine.LNX.3.95.1020909132344.17307A-100000@chaos.analogic.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Richard B. Johnson" <root@chaos.analogic.com>
   Date: Mon, 9 Sep 2002 13:29:42 -0400 (EDT)
   
   I think there is a virt_to_bus() macro and its inverse.

Which is deprecate and not to be used by any new code.
Use Documentation/DMA-mapping.txt instead.

If you meant virt_to_phys(), this does not work on arbitrary
kernel virtual addresses either only direct mapped ones
(ie. kmalloc() or get_free_page() data).
