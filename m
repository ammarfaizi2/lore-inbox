Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTBARGn>; Sat, 1 Feb 2003 12:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTBARGn>; Sat, 1 Feb 2003 12:06:43 -0500
Received: from boden.synopsys.com ([204.176.20.19]:24047 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S264910AbTBARGm>; Sat, 1 Feb 2003 12:06:42 -0500
Date: Sat, 1 Feb 2003 18:15:58 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Toon van der Pas <toon@hout.vanvergehaald.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre4+bk: undefined references for smp + apm
Message-ID: <20030201171558.GA28932@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <20030201153428.GJ5239@riesen-pc.gr05.synopsys.com> <20030201172805.B4845@vdpas.vanvergehaald.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030201172805.B4845@vdpas.vanvergehaald.nl>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toon van der Pas, Sat, Feb 01, 2003 17:28:05 +0100:
> On Sat, Feb 01, 2003 at 04:34:28PM +0100, Alex Riesen wrote:
> > 
> > arch/i386/kernel/kernel.o(.text+0xcd12): In function `apm_save_cpus':
> > : undefined reference to `set_cpus_allowed'
> > arch/i386/kernel/kernel.o(.text+0xcdbf): In function `apm_bios_call':
> > : undefined reference to `set_cpus_allowed'
> > arch/i386/kernel/kernel.o(.text+0xce56): In function `apm_bios_call_simple':
> > : undefined reference to `set_cpus_allowed'
> 
> make mrproper
> 

no, that's not the reason.

set_cpus_allowed doesn't appear anywhere in the tree,
only apm.c (with CONFIG_SMP defined) references it.

-alex

