Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbTK3Vke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 16:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTK3Vke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 16:40:34 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:6071 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S264347AbTK3Vkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 16:40:31 -0500
Date: Sun, 30 Nov 2003 22:40:25 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11, 2.6.0-test9 and gdb 6.0
Message-ID: <20031130214025.GO2935@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is there any issue about using gdb with pthreads under 2.6.0-test9+ kernels?

With 2.6.0-test11 I got message while du next over a function that creates some
threads:

Program received signal SIG32, Real-time event 32.
__pthread_sigsuspend (set=0xbffff6d0)
   at ../linuxthreads/sysdeps/unix/sysv/linux/pt-sigsuspend.c:5656	
   ../linuxthreads/sysdeps/unix/sysv/linux/pt-sigsuspend.c: No such file or directory.
   in ../linuxthreads/sysdeps/unix/sysv/linux/pt-sigsuspend.c
(gdb)

With 2.6.0-test9 I got a message about gdb cannot read thread registers.

With 2.4.x series it is ok. Is it a bug in ptrace in kernel or a bug in gdb?

-- 
Luká¹ Hejtmánek
