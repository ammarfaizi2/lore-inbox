Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129377AbQKCXKa>; Fri, 3 Nov 2000 18:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKCXKL>; Fri, 3 Nov 2000 18:10:11 -0500
Received: from ha2.rdc2.mi.home.com ([24.2.68.69]:3014 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129033AbQKCXKF>; Fri, 3 Nov 2000 18:10:05 -0500
Message-ID: <3A034588.4E06D5FC@didntduck.org>
Date: Fri, 03 Nov 2000 18:08:56 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 boot time check for cpu features
In-Reply-To: <E13rgMG-0003Uc-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Q:      are any of the things you test present in processors only after we
>         do magic 'cpuid' enable invocations ?

Hmm, after a bit more investigation, it appears that the Cyrix MII
processors support cmov instructions, even though we currently don't
compile for that processor with -march=i686.  Please ignore this patch
until I can come up with something better.

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
