Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266031AbRGLPhN>; Thu, 12 Jul 2001 11:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266062AbRGLPhD>; Thu, 12 Jul 2001 11:37:03 -0400
Received: from motgate4.mot.com ([144.189.100.102]:39056 "EHLO
	motgate4.mot.com") by vger.kernel.org with ESMTP id <S266031AbRGLPgq>;
	Thu, 12 Jul 2001 11:36:46 -0400
Message-Id: <3B4DC2CD.81DBB351@crm.mot.com>
Date: Thu, 12 Jul 2001 17:31:25 +0200
From: Emmanuel Varagnat <varagnat@crm.mot.com>
Organization: Motorola
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Giacomo Catenazzi <cate@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Makefile problem and modules
In-Reply-To: <fa.fo00suv.1ug283k@ifi.uio.no> <3B4DBFC9.4040108@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi wrote:
> 
> Emmanuel Varagnat wrote:
> 
> > I wrote a module for IPv6 but there is a case when it is
> > compiled.
> > (For the moment my code can only work as a module...)
> > When IPv6 is compiled as a module, my module is well compiled.
> > But if IPv6 is directly in the kernel, my module is not take
> > into account (I've got no object file).
> >
> > Here is the only line I added to the Makefile (near the end):
> >
> > obj-$(CONFIG_IPV6_MYSTUFF)  += mystuff.o
> >
> 
> Changes in the Config.in file?

Yes just a tristate option.
And after doing config/menuconfig/xconfig, the .config file
contain a line with CONFIG_IPV6_MYSTUFF=m

I can't figure out where it comes from.
I must say I also read Documentation/kbuild/makefiles.txt.

Thanks.

-Manu
