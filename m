Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSCOO3C>; Fri, 15 Mar 2002 09:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292594AbSCOO2w>; Fri, 15 Mar 2002 09:28:52 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:2062 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S292588AbSCOO2l>; Fri, 15 Mar 2002 09:28:41 -0500
Message-Id: <200203151425.g2FEPIq21588@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] struct super_block cleanup - msdos/vfat
Date: Fri, 15 Mar 2002 16:24:49 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Brian Gerst <bgerst@didntduck.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0203150619390.2253-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0203150619390.2253-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 March 2002 09:27, Alexander Viro wrote:
> On Fri, 15 Mar 2002, Denis Vlasenko wrote:
> > Does this mean umsdos can be layered atop of wider range of filesystems
> > than just msdos? That would be cool.
>
> Yes, but what's cool about it?  If not for the fact that there are weird
> setups that actually use umsdos (i.e. compatibility reasons), the best
> way to deal with it would be rm -rf...  If underlying filesystem has
> normal semantics - you don't need anything, if it doesn't...  I'd suggest
> to use combination of tar(1) and ramfs.  At least that way you get full
> Unix semantics - no mess with rename breaking links, etc.

Well, I initially come here from DOS/Win world and in fact actually used 
umsdos for some time (heck, it's still installed on one abandoned box).
But I presume there are other worlds (maybe Mac?) with filesystems unsuited 
for Linux root fs (like fat), why invent u[fs] for them too?

OTOH it means extra effort in umsdos rewrite, and since I don't do that 
effort, I'd better shut up now.
--
vda
