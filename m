Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276114AbRI1PQ2>; Fri, 28 Sep 2001 11:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276113AbRI1PQI>; Fri, 28 Sep 2001 11:16:08 -0400
Received: from mail.berlin.de ([195.243.105.33]:54761 "EHLO
	mailoutvl21.berlin.de") by vger.kernel.org with ESMTP
	id <S276116AbRI1PP6>; Fri, 28 Sep 2001 11:15:58 -0400
Message-ID: <3BB49438.1F2C59B3@berlin.de>
Date: Fri, 28 Sep 2001 17:16:08 +0200
From: Norbert Roos <n.roos@berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: inverse mmap() available?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

Is there a way to map user space memory into kernel address space, e.g.
that i don't have to call get_user(var,...) but simply use var =
*user_space_ptr?

What i intend to do (as the next step) is to DMA-transfer data directly
between a PCI device and user space memory. The buffer in user space
should be allocated with malloc(), so allocating a buffer in kernel and
mmap()-ping it to user space is not the solution..

I guess this has been asked before, any links to further information
would be great.

Thanks
Norbert
