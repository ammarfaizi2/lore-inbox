Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbRAaAKx>; Tue, 30 Jan 2001 19:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131449AbRAaAKn>; Tue, 30 Jan 2001 19:10:43 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:61201 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130993AbRAaAKg>;
	Tue, 30 Jan 2001 19:10:36 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Andreas Ackermann (Acki)" <asackerm@stud.informatik.uni-erlangen.de>
Date: Wed, 31 Jan 2001 01:08:06 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Oops in 2.4.0: [kswapd+116/272]
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <14183E277294@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 01 at 0:36, Andreas Ackermann (Acki) wrote:
> Jan 29 08:17:39 ane kernel: CPU:    0
> Jan 29 08:17:39 ane kernel: EIP:    0010:[prune_dcache+24/328]
> Jan 29 08:17:39 ane kernel: EFLAGS: 00010216
> Jan 29 08:17:39 ane kernel: Call Trace: [shrink_dcache_memory+33/48]
> [do_try_to_free_pages+83/128] [kswapd+116/272] [kernel_thread+40/56]
> Jan 29 08:17:39 ane kernel:
> 
> If this tells somebody what it's all about I can provide further
> information about system etc. I also can provide three similar excerpts
> form my logfile ;-)

Is it always in prune_dcache? Which filesystems you have mounted
at oops, or just before oops? ncpfs? smbfs? vfat?
                                        Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
