Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQKTTDP>; Mon, 20 Nov 2000 14:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129411AbQKTTDF>; Mon, 20 Nov 2000 14:03:05 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:30214 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129166AbQKTTC4>;
	Mon, 20 Nov 2000 14:02:56 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Ben Collins <bcollins@debian.org>
Date: Mon, 20 Nov 2000 19:32:39 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Bug in large files ext2 in 2.4.0-test11 ?
CC: Zdenek Kabelac <kabi@fi.muni.cz>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <D69EF5976ED@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 00 at 13:19, Ben Collins wrote:
> 
> Does kernel 2.4.x compile and run well for all of our supported archs?

AFAIK yes. At least on all Debian archs.

> Do programs compiled against a glibc with LFS (2.4.x kernel) support, and
> using that LFS support, work on kernel 2.2.x machines?

Yes. Even glibc (2.2) compiled against kernel without LFS support has LFS
interface. Of course limited to 2GB files only.
 
> Secondly, anyone who thinks they know what they are doing, can simply
> download the Debian glibc sources files, and build against kernel-2.4.0
> headers with this simple command:
> 
> LINUX_SOURCE=/usr/src/linux-2.4.0-test11 apt-get -b source glibc
> 
> Simple, eh? :)

But time consuming... If you already invested CPU power to compile
that large beast...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
