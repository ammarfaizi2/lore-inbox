Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261536AbTCGLio>; Fri, 7 Mar 2003 06:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbTCGLio>; Fri, 7 Mar 2003 06:38:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38569
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261536AbTCGLin>; Fri, 7 Mar 2003 06:38:43 -0500
Subject: Re: Make ipconfig.c work as a loadable module.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Mueller <malware@t-online.de>
Cc: Russell King <rmk@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <200303070715.IAA27138@fire.malware.de>
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com>
	 <1046990052.18158.121.camel@irongate.swansea.linux.org.uk>
	 <20030306221136.GB26732@gtf.org>
	 <20030306222546.K838@flint.arm.linux.org.uk>
	 <1046996037.18158.142.camel@irongate.swansea.linux.org.uk>
	 <20030306231905.M838@flint.arm.linux.org.uk>
	 <1046996987.17718.144.camel@irongate.swansea.linux.org.uk>
	 <200303070715.IAA27138@fire.malware.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047041676.20793.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 12:54:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 07:15, Michael Mueller wrote:
> Hi Alan,
> Sorry, but I must join Russel here. I have atleast one machine which has
> a bootloader able to load exactly one file only. There is currently no
> way to load an initrd. It would need to implement the whole (BOOTP+)TFTP
> stuff again, just to get the initrd. So I was quite happy linux 2.4
> still knows about mounting a NFS root filesystem without user-space
> help.

Just glue the initrd to the kernel. This is not rocket science

