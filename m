Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSKJArq>; Sat, 9 Nov 2002 19:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSKJArq>; Sat, 9 Nov 2002 19:47:46 -0500
Received: from fmr02.intel.com ([192.55.52.25]:56794 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262838AbSKJArp>; Sat, 9 Nov 2002 19:47:45 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7807B7E080@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: RE: [2.5. PATCH] cpufreq: correct initialization on Intel Copperm
	ines
Date: Sat, 9 Nov 2002 16:54:27 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> [2.5. PATCH] cpufreq: Intel Coppermines -- the saga continues.
> 
> The detection process for speedstep-enabled Pentium III Coppermines is
> considered proprietary by Intel. The attempt to detect this
> capability using MSRs failed. So, users need to pass the option
> "speedstep_coppermine=1" to the kernel (boot option or parameter) if
> they own a SpeedStep capable PIII Coppermine processor. Tualatins work
> as before.

Cannot you use ACPI to detect that? AFAIK, if the machine supports it, it is
doable.

Cheers, 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]
