Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289880AbSAPD3b>; Tue, 15 Jan 2002 22:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289965AbSAPD3V>; Tue, 15 Jan 2002 22:29:21 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40936 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289880AbSAPD3N>;
	Tue, 15 Jan 2002 22:29:13 -0500
Date: Tue, 15 Jan 2002 22:29:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: David Garfield <garfield@irving.iisd.sra.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com>
Message-ID: <Pine.GSO.4.21.0201152226100.4339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Jan 2002, David Garfield wrote:

> Hearing all this talk about initramfs and eliminating hardwired
> drivers, it occurs to me to ask:
> 
> 
> 
> Can/will the initramfs mechanism be made to implicitly load into the
> kernel the modules (or some of the modules) in the image?

No.  The point of initramfs is to remove crap from kernel and switch
to using normal code paths for late-boot stuff.  _Adding_ insmod
analog into the kernel?  No, thanks.

