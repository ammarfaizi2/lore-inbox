Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbQKKLm5>; Sat, 11 Nov 2000 06:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbQKKLmr>; Sat, 11 Nov 2000 06:42:47 -0500
Received: from sjc-wnds-1110.customers.reflexnet.net ([64.6.201.110]:24586
	"EHLO shambat.jokeslayer.com") by vger.kernel.org with ESMTP
	id <S130012AbQKKLmg>; Sat, 11 Nov 2000 06:42:36 -0500
Date: Sat, 11 Nov 2000 03:52:09 -0800 (PST)
From: Max Inux <maxinux@openpgp.net>
To: Tigran Aivazian <tigran@veritas.com>
cc: "H. Peter Anvin" <hpa@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.21.0011111133050.1029-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.30.0011110348540.10847-100000@shambat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May I recomend a read of Documentation/i386/boot.txt, it explains exactly
what is done

Protocol 2.02:  (Kernel 2.4.0-test3-pre3) New command line protocol.
                Lower the conventional memory ceiling.  No overwrite
                of the traditional setup area, thus making booting
                safe for systems which use the EBDA from SMM or 32-bit
                BIOS entry points.  zImage deprecated but still
                supported.

2.01 may have had the issue you speak of, looks like this fixes it.

William Tiemann
<wtiemann@openpgp.net>
http://www.OpenPGP.Net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
