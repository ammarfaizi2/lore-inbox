Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSG2SMM>; Mon, 29 Jul 2002 14:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317566AbSG2SMM>; Mon, 29 Jul 2002 14:12:12 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:32012 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317561AbSG2SMM>;
	Mon, 29 Jul 2002 14:12:12 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Pavel Machek <pavel@ucw.cz>
Date: Mon, 29 Jul 2002 20:14:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: What's wrong with ftp.cz.kernel.org?
CC: ftpadmin@kernel.org, admin@sh.cvut.cz, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <826CF406A8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 02 at 19:54, Pavel Machek wrote:
> Something is wrong with ftp.cz.kernel.org. Perhaps its time to
> redirect ftp.cz.kernel.org to ftp.de.kernel.org or something like that
> using DNS magic until its fixed?
> 
> pavel@amd:~$ lftp ftp.cz.kernel.org
> lftp ftp.cz.kernel.org:~> cd /pub/linux/kernel/v2.5
> cd ok, cwd=/pub/linux/kernel/v2.5

Do not use 147.32.127.222 aka ftp.sh.cvut.cz, which is part of
ftp.cz.kernel.org group. It was not updated for some time. We'll see
what sh.cvut.cz admin will tell us, but I assume that machine admin
left colledge at the end of June, and shortly thereafter mirroring
process died.

Use CUNI's 195.113.19.54, it should have same 100Mbps connectivity
to the world. If you want 1Gbps site, 
ftp.cesnet.cz/MIRRORS/ftp.kernel.org/pub/linux/kernel, but it is not 
an official Linux kernel mirroring site.

> lftp ftp.cz.kernel.org:/pub/linux/kernel/v2.5> get patch-2.5.29.bz
> Interrupt
> lftp ftp.cz.kernel.org:/pub/linux/kernel/v2.5> get patch-2.5.29.bz2
> get: Access failed: 550 Failed to open file. (patch-2.5.29.bz2)

                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
