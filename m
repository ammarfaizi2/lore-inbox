Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKKVlI>; Sat, 11 Nov 2000 16:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129504AbQKKVk6>; Sat, 11 Nov 2000 16:40:58 -0500
Received: from smtp-abo-5.wanadoo.fr ([193.252.19.58]:26806 "EHLO
	mahonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129092AbQKKVkm>; Sat, 11 Nov 2000 16:40:42 -0500
Message-ID: <3A0DBD06.3070409@wanadoo.fr>
Date: Sat, 11 Nov 2000 22:41:26 +0100
From: "reiser.angus" <reiser.angus@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i586; en-US; m18) Gecko/20001111
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.0-test11-pre2 compilation error:  undefined reference to `bust_spinlocks'
X-Priority: 1 (highest)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cannot make a success compilation of 2.4.0-test11pre2 with the same 
.config than for a successfull 2.4.0-test10 compilation.
Same problem when apply patch-2.4.0test11pre2-ac1 from alan cox

arch/i386/mm/mm.o: In function `do_page_fault':
arch/i386/mm/mm.o(.text+0x821): undefined reference to `bust_spinlocks'
make: *** [vmlinux] Erreur 1

bash-2.04$

use egcs 1.1.2

I can provide .config  i did not put it for size reasons.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
