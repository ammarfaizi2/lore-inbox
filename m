Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268496AbTCFW70>; Thu, 6 Mar 2003 17:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268511AbTCFW7Z>; Thu, 6 Mar 2003 17:59:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39080
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268496AbTCFW7W>; Thu, 6 Mar 2003 17:59:22 -0500
Subject: Re: Make ipconfig.c work as a loadable module.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <20030306222546.K838@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com>
	 <1046990052.18158.121.camel@irongate.swansea.linux.org.uk>
	 <20030306221136.GB26732@gtf.org>
	 <20030306222546.K838@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046996037.18158.142.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 00:13:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 22:25, Russell King wrote:
> > > The right fix is to delete ipconfig.c, it has been the right fix for a long
> > > long time. There are initrd based bootp/dhcp setups that can also then mount
> > > a root NFS partition and they do *not* need any kernel helper.
> > 
> > The klibc tarball on kernel.org also has ipconfig-type code, waiting for
> > initramfs early userspace :)
> > 
> > Many have wanted to delete ipconfig.c for a while now...
> 
> Yep, can't the deletion wait a couple more weeks or so until klibc gets
> merged?  It's not like ipconfig.c is broken currently, is it?

Thats how it ended up in 2.4. Klibc doesnt really matter, the apps exist
linked with dietlibc and stuff even without klibc.

Time for it to die

