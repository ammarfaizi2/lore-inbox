Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRJ0Oqt>; Sat, 27 Oct 2001 10:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270619AbRJ0Oqj>; Sat, 27 Oct 2001 10:46:39 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:55047 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S271741AbRJ0Oq1>; Sat, 27 Oct 2001 10:46:27 -0400
Date: Sat, 27 Oct 2001 16:39:43 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13ac2: small patch to arch/alpha/kernel/time.c needed for compilation
Message-ID: <20011027163943.A1334@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.13ac2/arch/alpha/kernel/time.c    Sat Oct 27 14:52:30 2001
+++ linux-2.4.13ac2-new/arch/alpha/kernel/time.c        Sat Oct 27 14:47:37 2001
@@ -209,7 +209,7 @@
                return cc;

        if (cc < (cpu_hz[index].min - FREQ_DEVIATION)
-           || cc > (cpu_hz[index].max + FREQ_DEVIATION)
+           || cc > (cpu_hz[index].max + FREQ_DEVIATION))
                return 0;

        return cc;

It really speaks for itself.

Good luck,
Jurriaan
-- 
If all is not lost, then where is it?
	Anonymous
GNU/Linux 2.4.13-ac2 SMP/ReiserFS 2x1402 bogomips load av: 0.41 0.15 0.05
