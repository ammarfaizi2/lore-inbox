Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUFPUtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUFPUtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUFPUtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:49:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264788AbUFPUsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:48:10 -0400
Date: Wed, 16 Jun 2004 16:47:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@ximian.com>
cc: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Programtically tell diff between HT and real
In-Reply-To: <1087411607.7869.3.camel@localhost>
Message-ID: <Pine.LNX.4.53.0406161644450.541@chaos>
References: <20040616174646.70010.qmail@web51805.mail.yahoo.com> 
 <1087408567.7869.1.camel@localhost> <1087411607.7869.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Robert Love wrote:

> On Wed, 2004-06-16 at 13:56 -0400, Robert Love wrote:
>
> > Yah.  Look at /proc/cpuinfo.
> >
> > Virtual processors have different 'processor' values but the same
> > 'physical id', while physical processors obviously have different values
> > for both.
>
> Oh, and if you just want to see if a processor supports HT - the 'ht'
> flag is set in 'flags' in /proc/cpuinfo.
>
> 	Robert Love
>


processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 7
cpu MHz		: 2793.087
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
  mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
                                                           ^_______
bogomips	: 5570.56

I would love to know how you turn in on! This is one of those
"latest-and-greatest" Intel D865PERL mother-boards and I've
even flashed the BIOS with the "latest-and-greatest".


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


