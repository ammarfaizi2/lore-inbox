Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVLMNHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVLMNHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVLMNHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:07:37 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:56220 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932087AbVLMNHg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:07:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lPINLQYAqHt+au6oC7r0pI1aAP2Htozu7T5rAZgRA5JfJkxEEU5Azs0zcn9bSpyQexZZ4sC3L+B8pQZ3Sxdu06454ByaWC5V5FawtL6P42999f2AHt+zjiF+uEX/1dnhUXnsRgxdBjs2O/4SU0Teq4hm0dJ/iPjw9hgxD77i8Q4=
Message-ID: <5a4c581d0512130507n698846ao719c389f3c3ee416@mail.gmail.com>
Date: Tue, 13 Dec 2005 14:07:35 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.15-rc5-git3] hpet.c causes FC4 GCC 4.0.2 to bomb with unrecognizable insn
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 CC      drivers/char/hpet.o
drivers/char/hpet.c: In function `hpet_calibrate':
drivers/char/hpet.c:803: Unrecognizable insn:
(insn/i 95 270 264 (parallel[
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("drivers/char/hpet.c") 452))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("drivers/char/hpet.c") 452))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 92 (nil))
    (nil))
drivers/char/hpet.c:803: confused by earlier errors, bailing out
make[2]: *** [drivers/char/hpet.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

--alessandro

 "So much can happen by accident
  No rhyme, no reason - no one's innocent"

   (Steve Wynn - "Under The Weather")
