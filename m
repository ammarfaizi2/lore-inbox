Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293465AbSCKDXY>; Sun, 10 Mar 2002 22:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293592AbSCKDXP>; Sun, 10 Mar 2002 22:23:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25146 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S293465AbSCKDW4>; Sun, 10 Mar 2002 22:22:56 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davej@suse.de (Dave Jones), gone@us.ibm.com (Patricia Gaughen),
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
In-Reply-To: <E16k33p-0006Ra-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Mar 2002 20:17:19 -0700
In-Reply-To: <E16k33p-0006Ra-00@the-village.bc.nu>
Message-ID: <m1u1rnztc0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I will tenatively vote in favor of this kind of action.  There
> > are a couple of directions to consider.  This is a two dimensional
> > problem.
> 
> That should not be suprising 
> 
> > Dimension 1.  Different basic hardware architectures. 
> >   (pc,numaq,visws,voyager)
> (and others upcoming)
> 
> > Dimension 2.  Different firmware implementations.  
> >   (pcbios,linuxbios,openfirmware,acpi?)
> 
> i386-pc-pcbios
> 
> Maybe autoconf got the concept right. You don't neccessarily want to think
> of it as a grid though. A lot of the stuff is i386-*-pcbios and i386-pc-*

Agreed, there is a lot of potential for sharing.

Eric



