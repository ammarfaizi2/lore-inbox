Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132202AbQK0BCJ>; Sun, 26 Nov 2000 20:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135171AbQK0BB7>; Sun, 26 Nov 2000 20:01:59 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:27890 "EHLO
        mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
        id <S132202AbQK0BBt>; Sun, 26 Nov 2000 20:01:49 -0500
Date: Mon, 27 Nov 2000 00:31:49 +0000
From: Toby Jaffey <toby@earth.li>
To: linux-kernel@vger.kernel.org
Subject: "hda lost interrupt" in 2.4-test11, fat32 corruption
Message-ID: <20001127003149.A435@twoey>
Reply-To: toby@earth.li
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Full description:
Using 2.4-test11 compiled with SMP support on my Abit BP6 (dual celeron
500s) I get consistent lost interrupt errors on hda (my only disk). My test
condition is untarring a 600mb archive of small files onto a FAT32
partition, which consistently fails. This usually results in processes
refusing to die, followed by the keyboard locking up. The machine is
still pingable, but remote logins fail. My test works fine in all 2.2
kernels I have tried and also in 2.4-test10.  My IDE chipset is the
PIIX4. At one point, I was forced to remove a FAT32 partition which
became severely corrupted, so I'm not willing to do any further testing,
sorry.

Keywords:
kernel, ide, smp, piix4

Environment:
Debian woody GNU/Linux, kernel 2.4-test11-smp, Abit BP6 (celeron 500s),
128mb, 1 0GB IDE disk.

-- 
(o_   | Toby Jaffey : www.nott.ac.uk/~psystrj/
//\   | "You're bound to be unhappy if you optimize everything." -- Donald E.
V_/_  | Knuth                                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
