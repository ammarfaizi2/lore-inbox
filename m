Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263674AbUDNEYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 00:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbUDNEYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 00:24:24 -0400
Received: from Soo.com ([199.202.113.33]:42002 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id S263674AbUDNEYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 00:24:22 -0400
Date: Wed, 14 Apr 2004 00:24:16 -0400
From: really bensoo_at_soo_dot_com <lnx-kern@soo.com>
To: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2
Message-ID: <20040414042416.GA17452@Sophia.soo.com>
Mail-Followup-To: Ross Dickson <ross@datscreative.com.au>,
	linux-kernel@vger.kernel.org
References: <200404131117.31306.ross@datscreative.com.au> <20040413040145.GA3327@Sophia.soo.com> <200404131455.52195.ross@datscreative.com.au> <20040413211824.GA12636@Sophia.soo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413211824.GA12636@Sophia.soo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i must add that i've been using your patches for
the nForce chipset since they first appeared on
this mailing list, and while they've all helped
this box to last a bit longer between lockups
none of them cured it.  Once the IO-APIC code was
compiled in and the Athlon idle powersaving
turned on it would inevitabley lock up in a day
or two.

This incorrect result from the mismatch between
your 2.6.3 patches and the current IO-APIC
code is the first time this box seems to be
free from lockup.

b

On Tue, Apr 13, 2004 at 05:18:24PM -0400, really bensoo_at_soo_dot_com wrote:
> My irq0 says XT-PIC.  i'm not complaining, box's still
> very stable and since the last post i've burned a few
> DVDs on it while running the file share client and
> playing music.
> 
> cat /proc/interrupts
> 
>            CPU0       
>   0:  759809583          XT-PIC  timer
>   1:     382279    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:    6386931    IO-APIC-edge  i8042
>  14:    2117474    IO-APIC-edge  ide0
>  15:    5575006    IO-APIC-edge  ide1
> 201:    6425958   IO-APIC-level  EMU10K1
> 209:  167929203   IO-APIC-level  eth0
> NMI:          0 
> LOC:  759718637 
> ERR:          0
> MIS:          0
