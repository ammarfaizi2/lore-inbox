Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129906AbQK0UcX>; Mon, 27 Nov 2000 15:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130147AbQK0UcN>; Mon, 27 Nov 2000 15:32:13 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:17931 "EHLO
        tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
        id <S129906AbQK0UcF>; Mon, 27 Nov 2000 15:32:05 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Mon, 27 Nov 2000 13:01:55 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11-ac2 and ac4 SMP will not run KDE 2.0
MIME-Version: 1.0
Message-Id: <00112713015500.00953@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to start KDE 2.0 with SMP builds
of 2.4.0-test11-ac2 and ac4, the system locks up
after "Loading Panel". Nothing odd gets logged
to /var/log/messages.

I can successfully run KDE 2.0 with UP builds 
of any of these kernels.

I can successfully run Gnome or Fvwm1 with
either UP or SMP builds of any of these kernels.

This table summarizes my experience with KDE 2.0
with recent 2.4.0-test11 and later kernels:

		UP	SMP

test11		OK	OK
test11-ac1	OK	OK
test11-ac2	OK	FAILS
test11-ac3	NOT TESTED
test11-ac4	OK	FAILS

The 2.4.0-test11-ac1 SMP kernel which successfully
runs KDE 2.0 has my small patch to
linux/include/asm-i386/hardirq.h which allowed an
SMP kernel to be built for test11-ac1.

The base distribution of this system is
Linux-Mandrake 7.2. The hardware is a Dell
Precision 420 Dual P-III. All kernels are patched with
linux-2.4.0-test10-reiserfs-3.6.19-patch.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
