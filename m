Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbTDAPAS>; Tue, 1 Apr 2003 10:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbTDAPAS>; Tue, 1 Apr 2003 10:00:18 -0500
Received: from mail.mtds.com ([194.204.200.6]:7824 "EHLO mail.mtds.com")
	by vger.kernel.org with ESMTP id <S262583AbTDAPAQ>;
	Tue, 1 Apr 2003 10:00:16 -0500
Date: Tue, 1 Apr 2003 15:11:29 +0000
From: Simon White <simon@mtds.com>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: New: SSE2 enabled by default on Celeron (P4 based)
Message-ID: <20030401151129.GB963@mtds.com>
References: <17080000.1049207466@[10.10.2.4]> <16009.43013.754047.36875@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16009.43013.754047.36875@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.64
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.10; VAE: 6.18.0.3; VDF: 6.18.0.20; host: vexira.mtds.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01-Apr-03 at 16:53, Mikael Pettersson (mikpe@user.it.uu.se) wrote :
> Martin J. Bligh writes:
>  > http://bugme.osdl.org/show_bug.cgi?id=527
>  > 
>  >            Summary: SSE2 enabled by default on Celeron (P4 based)
>  >     Kernel Version: 2.5.64
>  >             Status: NEW
>  >           Severity: normal
>  >              Owner: mbligh@aracnet.com
>  >          Submitter: simon@mtds.com
>  > 
>  > 
>  > Distribution: Customised RH 7.1 with many mods
>  > Hardware Environment: Celeron i686 (P4 based)
>  > Software Environment: gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)
>  > 
>  > Problem Description: Kernel compiles OK, but at boot kernel panics as CPU
>  > doesn't support SSE2
>  > 
>  > Steps to reproduce: Compile kernel choosing *any* Celeron option
>  > 
>  > /proc/cpuinfo:-
>  > processor       : 0
>  > vendor_id       : GenuineIntel
>  > cpu family      : 6
>  > model           : 11
> 
> This is NOT a P4-based Celeron. It's a P6 Tualatin Celeron, and as such,
> it does not support SSE2.
> 
> This CPU needs a kernel configured for a Pentium III or less.

Sorry. My reseller has told me a load of bull. In any case, I tried
compiling with all of the Celeron options, and I recall that _all_ set
SSE2, I think I must have screwed up on too much coffee, since checking
now, the .config file only has SSE2 flags for Celeron-P4, while I seem
to recall having compiled first for PIII-Celeron and still having the
kernel panic for SSE2, maybe somewhere the config files got screwed.

I feel so dumb.

-- 
|-Simon White, Internet Services Manager, Certified Check Point CCSA.
|-MTDS  Internet, Security, Anti-Virus, Linux and Hosting Solutions.
|-MTDS  14, rue du 16 novembre, Agdal, Rabat, Morocco.
|-MTDS  tel +212.3.767.4861 - fax +212.3.767.4863
