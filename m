Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314057AbSDVFkr>; Mon, 22 Apr 2002 01:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314058AbSDVFkq>; Mon, 22 Apr 2002 01:40:46 -0400
Received: from adsl-64-174-67-42.dsl.sntc01.pacbell.net ([64.174.67.42]:22713
	"EHLO moon.timocharis.com") by vger.kernel.org with ESMTP
	id <S314057AbSDVFkp>; Mon, 22 Apr 2002 01:40:45 -0400
Date: Sun, 21 Apr 2002 22:39:31 -0700
From: Akkana <akkana@shallowsky.com>
To: linux-kernel@vger.kernel.org
Subject: Re: power off (again)
Message-ID: <20020422053931.GA18478@shallowsky.com>
Mail-Followup-To: Akkana <akkana@shallowsky.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020418201220.C6D6247B1@debian.heim.lan> <1019162789.3361.0.camel@cristal> <20020419123743.DDB6847B5@debian.heim.lan> <20020418201220.C6D6247B1@debian.heim.lan> <1019163766.6743.8.camel@aurora> <20020419123026.A802D47B4@debian.heim.lan> <20020419230335.6454C755@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley writes:
> Just thought I'd give a "me too" response.  The Red Hat 7.2 kernel powers 
> down all three systems I've tried it on (a Dell Inspiron 3500 laptop, a 
> Toshiba Tecra 8000, and an SIS chipset motherboard).  The 2.4.18 and 2.4.17 
> kernels do NOT power down any of those systems

Christian Schoenebeck writes:
> I tried: APM only, ACPI only and I'm not really sure, but I think I also 
> tried ACPI & APM, but AFAIK this automatically enables just one of them 

Another data point: VIA KT266 chipset (MSI mobo) and ALI Magick1 chipset
(Soyo mobo), kernels 2.4.7, 2.4.17 and 2.4.18: enabling ACPI makes the
system power down correctly.  It doesn't matter whether APM is enabled,
nor whether "use real mode APM to power down" is enabled.  Single
processor, no SMP support in the kernel.  (Distro kernels tested:
stock Redhat 7.1, 7.2, and Mandrake 8.1 kernels do not power the
system down; the stock SuSE 7.3 kernel does.)

	...Akkana
