Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRB1Rdj>; Wed, 28 Feb 2001 12:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRB1RdU>; Wed, 28 Feb 2001 12:33:20 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:1033 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S129066AbRB1RdO>; Wed, 28 Feb 2001 12:33:14 -0500
Date: Wed, 28 Feb 2001 09:33:07 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: bradley mclain <bradley_kernel@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: -ac6 mis-reports cpu clock
In-Reply-To: <20010228062156.33159.qmail@web9204.mail.yahoo.com>
Message-ID: <Pine.LNX.4.31ksi3.0102280931130.6980-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, bradley mclain wrote:

Another oddity with ac6 (look for those 65+ GHz):

=== Cut ===
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes) (65044Mhz/65413Mhz FSB)
stepping	: 2
cpu MHz		: 400.917
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 799.53

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes) (65044Mhz/65413Mhz FSB)
stepping	: 2
cpu MHz		: 400.917
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 801.17
=== Cut ===

> here is an extract from dmesg from 2.4.2 and -ac6,
> showing a disparity in cpu clock speed..
>
> -ac6 has inserted a line claiming my clock is 400Mhz
> (it is actually 533 -- and i believe my fsb is 133).
>
> i don't think i compiled these two radically
> differently.  what could i have done wrong to cause
> this?  or has -ac6 introduced a bug of some sort?
>
> any suggestions for debugging or additional
> information?
>
> thanks,
> bradley mclain
>
> __________________________________________________
> Do You Yahoo!?
> Get email at your own domain with Yahoo! Mail.
> http://personal.mail.yahoo.com/

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV, 89014

