Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSI2QeW>; Sun, 29 Sep 2002 12:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSI2QeW>; Sun, 29 Sep 2002 12:34:22 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:11764 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262803AbSI2QeV>; Sun, 29 Sep 2002 12:34:21 -0400
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Matt Domsch <Matt_Domsch@Dell.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020929161144.GA19948@suse.de>
References: <20BF5713E14D5B48AA289F72BD372D6821CE34@AUSXMPC122.aus.amer.dell.com>
	<Pine.LNX.4.44.0209271606001.16331-100000@humbolt.us.dell.com> 
	<20020929161144.GA19948@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 17:44:59 +0100
Message-Id: <1033317899.13074.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 17:11, Dave Jones wrote:
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

Thats even more prevalent in things like the unmerged bits of the mips
tree. A lot of embedded processors have on chip everything - eg look at
the cirrus logic ARM chips or the Etrax.

The extra people use arch/foo/drivers



