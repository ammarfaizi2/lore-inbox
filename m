Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbTAQQA4>; Fri, 17 Jan 2003 11:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbTAQQA4>; Fri, 17 Jan 2003 11:00:56 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:12017 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267543AbTAQQAy>; Fri, 17 Jan 2003 11:00:54 -0500
Date: Fri, 17 Jan 2003 11:09:32 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbols building 2.5.59
In-Reply-To: <Pine.LNX.4.44.0301171003250.15056-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0301171107180.8105-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Kai Germaschewski wrote:

> On Fri, 17 Jan 2003, Robert P. J. Day wrote:
> 
> > 
> > tail end of "make modules_install":
> > 
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.59; fi
> > depmod: *** Unresolved symbols in /lib/modules/2.5.59/kernel/drivers/i2c/i2c-proc.ko
> > depmod: 	i2c_check_functionality
> > depmod: 	i2c_smbus_xfer
> > depmod: 	i2c_check_addr
> > depmod: 	i2c_adapter_id
> > depmod: *** Unresolved symbols in /lib/modules/2.5.59/kernel/fs/cramfs/cramfs.ko
> > depmod: 	zlib_inflate
> > depmod: 	zlib_inflate_workspacesize
> > depmod: 	zlib_inflateInit_
> > depmod: 	zlib_inflateReset
> > depmod: 	zlib_inflateEnd
> > 
> >   the first one seems to be i2c-proc looking for symbols in i2c-core,
> > which i selected and which was built.
> > 
> >   the second seems to be that cramfs needs zlib_inflate, which once
> > again i selected and which was built.
> 
> Which version of module-init-tools do you have? (see 
> Documentation/Changes)
> 
> --Kai

ah, i have no such RPM, so where's the canonical location for it?
and i'm assuming that it is a replacement for the older modutils,
is that it?

rday

