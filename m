Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbSADMsG>; Fri, 4 Jan 2002 07:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288620AbSADMr4>; Fri, 4 Jan 2002 07:47:56 -0500
Received: from [129.27.43.9] ([129.27.43.9]:44048 "EHLO xarch.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S288617AbSADMro>;
	Fri, 4 Jan 2002 07:47:44 -0500
Date: Fri, 4 Jan 2002 13:47:42 +0100 (CET)
From: Alex <mail_ker@xarch.tu-graz.ac.at>
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.33.0201041328190.18539-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.10.10201041344030.17142-100000@xarch.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Dave Jones wrote:

> On Fri, 4 Jan 2002, Alex wrote:
> 
> > > You're still going to need user interaction for a lot of these.
> > That is why I recommended that the textfile is the output of an
> > interactive hardware-detection tool. Yes, interactive. :-)
> 
> vim /etc/modules.conf
> is about as interactive as it gets.

Modules.conf is not all there is. What if modules.conf resides on an
scsi-harddisk with an scsi controller who is just making the problem of
ancient hardware in the first case ? etc.etc. You are running around with
the underlying assumption that you can - indeed - *acess* modules.conf via
*already detected* hardware. This is not the same assumption my textfile
example operates from. My textfile-for-kernel operates from the assumption
that *almost nothing whatsoever* on hardware is "fixed compiled" in the
kernel at the moment we're talking about it, and that the precompiled
modules will probably be loaded from the distro cd etc....

Later, Alex







