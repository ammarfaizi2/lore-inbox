Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbTCaXbb>; Mon, 31 Mar 2003 18:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbTCaXba>; Mon, 31 Mar 2003 18:31:30 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:7437 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261921AbTCaXb1>; Mon, 31 Mar 2003 18:31:27 -0500
Date: Tue, 1 Apr 2003 01:42:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Joel Becker <Joel.Becker@oracle.com>, bert hubert <ahu@ds9a.nl>,
       Greg KH <greg@kroah.com>, <Andries.Brouwer@cwi.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <1049149133.1287.1.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304010137250.5042-100000@serv>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl> 
 <Pine.LNX.4.44.0303272245490.5042-100000@serv> 
 <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk> 
 <Pine.LNX.4.44.0303280008530.5042-100000@serv>  <20030327234820.GE1687@kroah.com>
  <Pine.LNX.4.44.0303281031120.5042-100000@serv>  <20030328180545.GG32000@ca-server1.us.oracle.com>
  <Pine.LNX.4.44.0303281924530.5042-100000@serv>  <20030331083157.GA29029@outpost.ds9a.nl>
  <Pine.LNX.4.44.0303311039190.5042-100000@serv>  <20030331172403.GM32000@ca-server1.us.oracle.com>
  <Pine.LNX.4.44.0303312215020.5042-100000@serv>
 <1049149133.1287.1.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31 Mar 2003, Alan Cox wrote:

> > 2. What compromises can we make for 2.6?
> 
> Defaulting char devices to 256 minors and a lot of space so stuff doesnt
> break. Viro has done the block stuff and we have the scope to do sane
> stuff like /dev/disk/.. for all disks now.

What do you mean with "a lot of space so stuff doesnt break"?

> > Without answering these questions now, we risk to pay heavily for it 
> > later. The ones who ask now for a larger dev_t the loudest are likely the 
> > first to demand later not change anything for "compability", because they 
> > hardcoded certain assumptions about dev_t into their applications.
> 
> Glibc already has a bigger dev_t

and a broken mknod implementation...

bye, Roman

