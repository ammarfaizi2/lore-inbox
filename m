Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272504AbTHKLfQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 07:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272508AbTHKLfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 07:35:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33504 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272504AbTHKLfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 07:35:08 -0400
Date: Mon, 11 Aug 2003 13:34:33 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: <ak@suse.de>, <kwijibo@zianet.com>, Dave Jones <davej@redhat.com>,
       <richard.brunner@amd.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Machine check expection panic
In-Reply-To: <20030811101522.GA8080@vana.vc.cvut.cz>
Message-ID: <Pine.SOL.4.30.0308111330550.11836-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just "me too".

MCE: The hardware reports a non fatal, correctable incident occurred on
CPU 0.
Bank 0: 8000000000002140

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 1700+
stepping        : 1
cpu MHz         : 1467.033
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2883.58

--bartlomiej

On Mon, 11 Aug 2003, Petr Vandrovec wrote:

> Out of curiosity, I never got MCE on my system at home (last kernel
> before one below was 2.6.0-test2, and it did not complain for
> different kernels at least since November 2001), yet after recent MCE
> changes I got during fsck:
>
> MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> Bank 0: f65980000000baff

