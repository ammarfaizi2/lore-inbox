Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTAQPzq>; Fri, 17 Jan 2003 10:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbTAQPzq>; Fri, 17 Jan 2003 10:55:46 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:44708 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267542AbTAQPzp>; Fri, 17 Jan 2003 10:55:45 -0500
Date: Fri, 17 Jan 2003 10:04:38 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbols building 2.5.59
In-Reply-To: <Pine.LNX.4.44.0301171055180.8002-100000@dell>
Message-ID: <Pine.LNX.4.44.0301171003250.15056-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Robert P. J. Day wrote:

> 
> tail end of "make modules_install":
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.59; fi
> depmod: *** Unresolved symbols in /lib/modules/2.5.59/kernel/drivers/i2c/i2c-proc.ko
> depmod: 	i2c_check_functionality
> depmod: 	i2c_smbus_xfer
> depmod: 	i2c_check_addr
> depmod: 	i2c_adapter_id
> depmod: *** Unresolved symbols in /lib/modules/2.5.59/kernel/fs/cramfs/cramfs.ko
> depmod: 	zlib_inflate
> depmod: 	zlib_inflate_workspacesize
> depmod: 	zlib_inflateInit_
> depmod: 	zlib_inflateReset
> depmod: 	zlib_inflateEnd
> 
>   the first one seems to be i2c-proc looking for symbols in i2c-core,
> which i selected and which was built.
> 
>   the second seems to be that cramfs needs zlib_inflate, which once
> again i selected and which was built.

Which version of module-init-tools do you have? (see 
Documentation/Changes)

--Kai


