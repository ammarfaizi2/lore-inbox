Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131315AbQKYRYC>; Sat, 25 Nov 2000 12:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131329AbQKYRXw>; Sat, 25 Nov 2000 12:23:52 -0500
Received: from mx.oau.org ([208.46.16.50]:9743 "EHLO mx.oau.org")
        by vger.kernel.org with ESMTP id <S131315AbQKYRXh>;
        Sat, 25 Nov 2000 12:23:37 -0500
Date: Sat, 25 Nov 2000 11:21:16 -0500
From: "Steven S. Dick" <ssd@nevets.oau.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: 2.4.0-test11 (pre1, final) OOPS during boot/modprobe
Message-ID: <20001125112116.A5536@nevets.oau.org>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <6809.975153913@ocs3.ocs-net> <200011251227.eAPCRPe19247@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200011251227.eAPCRPe19247@flint.arm.linux.org.uk>; from Russell King on Sat, Nov 25, 2000 at 12:27:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 12:27:24PM +0000, Russell King wrote:
> Keith Owens writes:
> Steven probably wants to apply this patch to test11:

How about we apply both that patch and this one?

diff -u linux/Documentation/Changes.old linux/Documentation/Changes
--- linux/Documentation/Changes.old	Sat Nov 25 11:18:00 2000
+++ linux/Documentation/Changes	Sat Nov 25 11:18:28 2000
@@ -52,7 +52,7 @@
 o  Gnu make               3.77                    # make --version
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # kbdrate -v
-o  modutils               2.3.18                  # insmod -V
+o  modutils               2.3.21                  # insmod -V
 o  e2fsprogs              1.19                    # tune2fs --version
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
