Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130962AbRBQM2c>; Sat, 17 Feb 2001 07:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRBQM2W>; Sat, 17 Feb 2001 07:28:22 -0500
Received: from [132.69.253.254] ([132.69.253.254]:31758 "HELO
	vipe.technion.ac.il") by vger.kernel.org with SMTP
	id <S130962AbRBQM2G>; Sat, 17 Feb 2001 07:28:06 -0500
Date: Sat, 17 Feb 2001 14:20:03 +0200 (IST)
From: Igor Yanover <yanover@vipe.technion.ac.il>
To: linux-kernel@vger.kernel.org
Subject: More on IO-APIC trouble
Message-ID: <Pine.LNX.4.10.10102171401540.7724-100000@vipe.technion.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Recently I came across two more things, that are possibly related to
IO-APIC problems:
1)http://xfree86.org/pipermail/xpert/2001January/004751.html
    Someone with SMP that has problem with interrupt delivery (stuck
interrupt). Only in SMP mode and this is not NE2000 related.
2)http://developer.intel.com/software/idap/media/pdf/copy.pdf ( Page 8
footer)
   It turns out, that there's an errata in early Pentium III revisions,
that could corrupt data written to IO-APIC. ( Only if SSE write is
followed by an APIC write)
                                    Igor

