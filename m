Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262797AbSI2QOn>; Sun, 29 Sep 2002 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262798AbSI2QOn>; Sun, 29 Sep 2002 12:14:43 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:56849 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S262797AbSI2QOl>; Sun, 29 Sep 2002 12:14:41 -0400
Date: Sun, 29 Sep 2002 12:18:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Matt Domsch <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
In-Reply-To: <20020929161144.GA19948@suse.de>
Message-ID: <Pine.LNX.4.44.0209291217540.24805-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Dave Jones wrote:

> On Fri, Sep 27, 2002 at 04:30:29PM -0500, Matt Domsch wrote:
>  >  arch/i386/kernel/edd.c           |  522 +++++++++++++++++++++++++++++++++++++++
>  >  arch/i386/kernel/i386_ksyms.c    |    6 
>  >  arch/i386/kernel/setup.c         |   20 +
> 
> Something that's been bothering me for a while, has been the
> proliferation of 'driver' type things appearing in arch/i386/kernel/
> My initial thought was to move the various CPU related 'drivers'
> (msr,cpuid,bluesmoke,microcode) to arch/i386/cpu/  [1]
> but I'm now wondering if an arch/i386/driver/ would be a better alternative.
> 
> Opinions?

Then again, drivers/char has some x86 specific drivers too (e.g. RNGs), 
perhaps it really should get dumped in drivers/

	Zwane
-- 
function.linuxpower.ca

