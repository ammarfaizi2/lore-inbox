Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTICIAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbTICIAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:00:48 -0400
Received: from ip119-170.introweb.nl ([80.65.119.170]:29568 "EHLO
	laptop.locamation.com") by vger.kernel.org with ESMTP
	id S261484AbTICIAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:00:46 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: Kars de Jong <jongk@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0309011027310.5048-100000@waterleaf.sonytel.be>
References: <Pine.GSO.4.21.0309011027310.5048-100000@waterleaf.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1062576038.1221.4.camel@laptop.locamation.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Sep 2003 10:00:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-01 at 10:34, Geert Uytterhoeven wrote:
> BTW, probably you want us to run your test program on other m68k boxes? Mine
> got a 68040, that leaves us with:
>   - 68030

Ah, I forgot, I've got one of these here too, a Motorola MVME147 board:

sasscm:/tmp# time ./jamie_test2
Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: FAIL - cache not coherent
Test separation: 16384 bytes: FAIL - cache not coherent
Test separation: 32768 bytes: FAIL - cache not coherent
Test separation: 65536 bytes: FAIL - cache not coherent
Test separation: 131072 bytes: FAIL - cache not coherent
Test separation: 262144 bytes: FAIL - cache not coherent
Test separation: 524288 bytes: FAIL - cache not coherent
Test separation: 1048576 bytes: FAIL - cache not coherent
Test separation: 2097152 bytes: FAIL - cache not coherent
Test separation: 4194304 bytes: FAIL - cache not coherent
Test separation: 8388608 bytes: FAIL - cache not coherent
Test separation: 16777216 bytes: FAIL - cache not coherent
VM page alias coherency test: failed; will use copy buffers instead
 
real    0m1.149s
user    0m0.240s
sys     0m0.670s
sasscm:/tmp# cat /proc/cpuinfo
CPU:            68030
MMU:            68030
FPU:            68882
Clocking:       19.6MHz
BogoMips:       4.90
Calibration:    24512 loops

Regards,

Kars.

