Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUJ3Pgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUJ3Pgq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUJ3Pgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:36:43 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:47764 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261201AbUJ3Ojj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:39:39 -0400
Message-ID: <4183A79B.7000906@kolivas.org>
Date: Sun, 31 Oct 2004 00:39:23 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 14/28] add Makefile changes
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9A604C0AC0CA6F70BB293337"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A604C0AC0CA6F70BB293337
Content-Type: multipart/mixed;
 boundary="------------030406000906060201000207"

This is a multi-part message in MIME format.
--------------030406000906060201000207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

add Makefile changes



--------------030406000906060201000207
Content-Type: text/plain;
 name="buildchanges"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="buildchanges"

Add necessary changes to Makefile.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm1/kernel/Makefile
===================================================================
--- linux-2.6.10-rc1-mm1.orig/kernel/Makefile	2004-10-28 07:57:28.244465128 +1000
+++ linux-2.6.10-rc1-mm1/kernel/Makefile	2004-10-28 07:58:21.672342856 +1000
@@ -2,12 +2,12 @@
 # Makefile for the linux kernel.
 #
 
-obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
+obj-y     = scheduler.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o
+	    kthread.o wait.o kfifo.o sched.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o


--------------030406000906060201000207--

--------------enig9A604C0AC0CA6F70BB293337
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6ebZUg7+tp6mRURAuA6AJ4jVZ7Iz/1ZYmmap8Fv9JLEJJiFkwCfZB6O
+NLti6JTB6JIXMZn2TwaD0g=
=7el0
-----END PGP SIGNATURE-----

--------------enig9A604C0AC0CA6F70BB293337--
