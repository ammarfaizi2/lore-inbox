Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTLOP4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTLOP4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:56:10 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:18863 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263798AbTLOP4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:56:03 -0500
Date: Mon, 15 Dec 2003 16:56:01 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Craig Bradney <cbradney@zip.com.au>
Cc: ross@datscreative.com.au, recbo@nishanet.com, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup,
 apic, io-apic, udma133 covered
In-Reply-To: <1071500545.6680.15.camel@athlonxp.bradney.info>
Message-ID: <Pine.LNX.4.55.0312151652260.22939@jurand.ds.pg.gda.pl>
References: <200312160030.30511.ross@datscreative.com.au>
 <1071500545.6680.15.camel@athlonxp.bradney.info>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003, Craig Bradney wrote:

>            CPU0
>   0:  245382420    IO-APIC-edge  timer
>   1:     139577    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          3    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:    1478615    IO-APIC-edge  i8042
>  14:    1055548    IO-APIC-edge  ide0
>  15:     737664    IO-APIC-edge  ide1
>  19:   18405692   IO-APIC-level  radeon@PCI:3:0:0
>  21:    5257090   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
>  22:          3   IO-APIC-level  ohci1394
> NMI:      14944
> LOC:  245087891
> ERR:          0
> MIS:          6
> 
> As for NMI.. I actually forget which I booted from... I think =1, but NMI is a small number now.. would it have wrapped?

 That's "=2" -- otherwise the NMI count would be rougly the same as the
sum of counts for IRQ 0 for all processors.  And you can actually get your
kernel's command line from /proc/cmdline.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
