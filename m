Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSGQM3E>; Wed, 17 Jul 2002 08:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSGQM3D>; Wed, 17 Jul 2002 08:29:03 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16120 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312558AbSGQM3C>; Wed, 17 Jul 2002 08:29:02 -0400
Subject: Re: Linux 2.4.19-rc1-ac7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020717114605.GA12575@duron.intern.kubla.de>
References: <200207171056.g6HAuXR24678@devserv.devel.redhat.com> 
	<20020717114605.GA12575@duron.intern.kubla.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 14:41:40 +0100
Message-Id: <1026913300.2119.138.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 12:46, Dominik Kubla wrote:
> > Linux 2.4.19rc1-ac7
> 
> Seems to have some problems:
> 
> [...]
> make[1]: Entering directory `/usr/src/linux'
> scripts/split-include include/linux/autoconf.h include/config
> /usr/bin/make -r -f tmp_include_depends all
> make[2]: Entering directory `/usr/src/linux'
> make[2]: *** No rule to make target
> `/usr/src/linux/fs/inflate_fs/infblock.h', needed by
> `/usr/src/linux/fs/inflate_fs/infcodes.h'.  Stop.

Misapplied/broken patch, or not running make depend ?

