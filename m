Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbTCGJNY>; Fri, 7 Mar 2003 04:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbTCGJNY>; Fri, 7 Mar 2003 04:13:24 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:37390 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261441AbTCGJNX>; Fri, 7 Mar 2003 04:13:23 -0500
Message-Id: <200303070913.h279Cpu07949@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Make ipconfig.c work as a loadable module.
Date: Fri, 7 Mar 2003 11:10:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <20030306231905.M838@flint.arm.linux.org.uk> <1046996987.17718.144.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1046996987.17718.144.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 March 2003 02:29, Alan Cox wrote:
> On Thu, 2003-03-06 at 23:19, Russell King wrote:
> > "klibc doesnt really matter"
> >
> > I'd prefer not to have to have thousands of special programs around
> > just to be able to boot my machines, especially when it was all in-
> > kernel up until this point.
> >
> > klibc yes, dietlibc with random other garbage in some random
> > filesystem which'd need maintaining - no thanks.
>
> You can build the dhcp client with glibc static into your initrd.

Anything built static against glibs tends to be 400K+.
--
vda
