Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266559AbRGGUz2>; Sat, 7 Jul 2001 16:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266562AbRGGUzS>; Sat, 7 Jul 2001 16:55:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:28677 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266559AbRGGUzG>; Sat, 7 Jul 2001 16:55:06 -0400
To: linux-kernel@vger.kernel.org
From: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: Machine check exception? (2.4.6+SMP+VIA)
Date: 7 Jul 2001 13:54:19 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9i7str$f30$1@tazenda.transmeta.com>
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKEEAIEMAA.vhou@khmer.cc>
Reply-To: hpa@transmeta.com (H. Peter Anvin)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <HDEBKHLDKIDOBMHPKDDKEEAIEMAA.vhou@khmer.cc>
By author:    "Vibol Hou" <vhou@khmer.cc>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> I was running 2.4.6-stable in SMP mode on a dual P3-1GHz machine (VIA 694D
> Chipset / MSI-6321 M/B + ) and the following message popped up after which
> the system hardlocked (no SysRQ input).  What does this message mean?
> 
> CPU 1: Machine Check Exception: 0000000000000004
> Bank 1: b200000000000115
> Kernel panic: CPU context corrupt
> 
> Message from syslogd@delta at Sat Jul  7 13:18:36 2001 ...
> delta kernel: CPU 1: Machine Check Exception: 0000000000000004
> 
> Message from syslogd@delta at Sat Jul  7 13:18:36 2001 ...
> delta kernel: Bank 1: b200000000000115
> 
> Message from syslogd@delta at Sat Jul  7 13:18:36 2001 ...
> delta kernel: Kernel panic: CPU context corrupt
> 

It means your hardware is bad.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
