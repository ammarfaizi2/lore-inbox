Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271987AbRI0ION>; Thu, 27 Sep 2001 04:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271989AbRI0IOC>; Thu, 27 Sep 2001 04:14:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7809 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271987AbRI0IN7>;
	Thu, 27 Sep 2001 04:13:59 -0400
Date: Thu, 27 Sep 2001 01:14:07 -0700 (PDT)
Message-Id: <20010927.011407.125896855.davem@redhat.com>
To: mac@melware.de
Cc: mingo@elte.hu, guoqiang@intec.iscas.ac.cn, linux-kernel@vger.kernel.org
Subject: Re: Question about ioremap and io_remap_page_range
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.31.0109271001001.25611-100000@phoenix.one.melware.de>
In-Reply-To: <Pine.LNX.4.33.0109270847070.2745-100000@localhost.localdomain>
	<Pine.LNX.4.31.0109271001001.25611-100000@phoenix.one.melware.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Armin Schindler <mac@melware.de>
   Date: Thu, 27 Sep 2001 10:03:26 +0200 (MEST)
   
   virt_to_phys() is obsolete ? What should be used if I need the phys address
   of a memory page ? (e.g. for mmap() remapping)
   
Ingo really is talking about virt_to_bus/bus_to_virt.

Franks a lot,
David S. Miller
davem@redhat.com
