Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130343AbQKLJCT>; Sun, 12 Nov 2000 04:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130352AbQKLJCA>; Sun, 12 Nov 2000 04:02:00 -0500
Received: from DKBH-T-003-p-249-178.tmns.net.au ([203.54.249.178]:45586 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S130343AbQKLJB6>;
	Sun, 12 Nov 2000 04:01:58 -0500
Message-ID: <3A0E5C71.D12A25C2@eyal.emu.id.au>
Date: Sun, 12 Nov 2000 20:01:37 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test11-pre3 - md.c compile error
In-Reply-To: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Drivers, drivers, drivers. IrDA and ISDN. PPC.

Got compile errors in drivers/md/md.c, had to add
        #include <linux/fs.h>
before
        #include <linux/sysctl.h>

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
