Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTIZSgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTIZSgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:36:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:6868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261569AbTIZSfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:35:41 -0400
Date: Fri, 26 Sep 2003 11:35:22 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?B=F6rkur_Ingi_J=F3nsson?= <bugsy@isl.is>
Cc: linux-kernel@vger.kernel.org
Subject: Re: khubd is a Succubus!
Message-ID: <20030926183522.GB17690@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <200309261724.56616.bugsy@isl.is> <200309261827.28606.bugsy@isl.is> <20030926182229.GA17041@kroah.com> <200309261843.10099.bugsy@isl.is>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309261843.10099.bugsy@isl.is>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 06:43:10PM +0000, Börkur Ingi Jónsson wrote:
> nvidia: no version magic, tainting kernel.
> nvidia: module license 'NVIDIA' taints kernel.
> 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 
> 16 19:03:09 PDT 2003
> 0: NVRM: AGPGART: unable to retrieve symbol table

Does this same problem happen without the nvidia driver loaded?

> > > 2. I have a usb keyboard plugged in It's packard Bell model number 9201
> > >
> > > 3. This did not happen with 2.4
> > >
> > > 4. ACPI is for laptops correct? I'm using a desktop and I've never
> > > installed anything ACPI related..
> >
> > But is ACPI configured in your kernel?
> 
> I checked the config and ACPI was configured.. Now compiling without ACPI. Is 
> that the reason? I think it was selected by default. 

I do not know, but if you do not need it, it should not be selected.


greg k-h
