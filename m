Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSGQRKu>; Wed, 17 Jul 2002 13:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSGQRKu>; Wed, 17 Jul 2002 13:10:50 -0400
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:27264 "EHLO
	bluesong.NET") by vger.kernel.org with ESMTP id <S315442AbSGQRKt> convert rfc822-to-8bit;
	Wed, 17 Jul 2002 13:10:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@bluesong.net>
Reply-To: jfv@bluesong.net
To: Dominik Kubla <dominik.kubla@uni-mainz.de>, Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.19-rc1-ac7
Date: Wed, 17 Jul 2002 10:14:58 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200207171056.g6HAuXR24678@devserv.devel.redhat.com> <20020717114605.GA12575@duron.intern.kubla.de>
In-Reply-To: <20020717114605.GA12575@duron.intern.kubla.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207171014.58760.jfv@bluesong.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 04:46 am, Dominik Kubla wrote:
> On Wed, Jul 17, 2002 at 06:56:33AM -0400, Alan Cox wrote:
> > [+ indicates stuff that went to Marcelo, o stuff that has not,
> >  * indicates stuff that is merged in mainstream now, X stuff that proved
> >    bad and was dropped out]
> >
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
> make[2]: Leaving directory `/usr/src/linux'
> make[1]: *** [tmp_include_depends] Error 2
> make[1]: Leaving directory `/usr/src/linux'
> make: *** [stamp-build] Error 2
>
> Dominik

Ran into this on ac6 also, its just a matter of doing a `make mrproper` 
and redo depends.

Cheers,
 
--
Jack F Vogel
IBM Linux Technology Center
jfv@us.ibm.com (work)
jfv@bluesong.net (peace and quiet)
