Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbQKACYK>; Tue, 31 Oct 2000 21:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbQKACYA>; Tue, 31 Oct 2000 21:24:00 -0500
Received: from atol.icm.edu.pl ([212.87.0.35]:46092 "EHLO atol.icm.edu.pl")
	by vger.kernel.org with ESMTP id <S131134AbQKACXt>;
	Tue, 31 Oct 2000 21:23:49 -0500
Date: Wed, 1 Nov 2000 03:23:41 +0100
From: Rafal Maszkowski <rzm@icm.edu.pl>
To: "David S. Miller" <davem@redhat.com>
Cc: rzm@icm.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7 on Sparc
Message-ID: <20001101032341.A10273@burza.icm.edu.pl>
In-Reply-To: <20001031191123.A9831@burza.icm.edu.pl> <200010312032.MAA09369@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.1i
In-Reply-To: <200010312032.MAA09369@pizda.ninka.net>; from davem@redhat.com on Tue, Oct 31, 2000 at 12:32:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 12:32:02PM -0800, David S. Miller wrote:
>    From: Rafal Maszkowski <rzm@icm.edu.pl>
>    I am trying to run 2.4 kernel to have up to date ATM on SPARCstation 10,
>    possibly with 2 CPUs. Did not succeed to boot neither Linus nor CVS version
>    recently.  Compilation of 2.4.0.10.7:
> Current CVS has both of these errors fixed, and such patches
> were sent to Linus (included below):

Thanks! It looks like Linus included them in 2.4.0.10. But the kernel still
does not boot.  It says 'Watchdog' but other recent versions were giving just
some nonsense-messages so I guess it jumps into some random place after
decompressing. 2.2 kernels work on this machine.

boot: 10
Uncompressing image...
PROMLIB: obio_ranges 5
bootmem_init: Scan sp_banks,  init_bootmem(spfn[1f5],bpfn[1f5],mlpfn[c000])
free_bootmem: base[0] size[1000000]
free_bootmem: base[4000000] size[1000000]
free_bootmem: base[8000000] size[1000000]
reserve_bootmem: base[0] size[1f5000]
reserve_bootmem: base[1f5000] size[1800]
Booting Linux...

Watchdog Reset
Type  help  for more information
ok

R.
-- 
W iskier krzesaniu ¿ywem/Materia³ to rzecz g³ówna
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
