Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTEFMp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbTEFMp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:45:56 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:50700 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262728AbTEFMpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:45:53 -0400
Date: Tue, 6 May 2003 14:58:21 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]   include/linux/sunrpc/svc.h compilation error
In-Reply-To: <1052222558.3873.19.camel@nalesnik>
Message-ID: <Pine.LNX.4.51L.0305061457160.1232@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com> 
 <Pine.LNX.4.51L.0305061205400.1232@piorun.ds.pg.gda.pl> <1052222558.3873.19.camel@nalesnik>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Grzegorz Jaskiewicz wrote:
> > That kernel fails for me when building...
> > [cut]
> > 
> > gcc -Wp,-MD,fs/lockd/.clntproc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=clntproc -DKBUILD_MODNAME=lockd -c -o fs/lockd/.tmp_clntproc.o fs/lockd/clntproc.c
> > In file included from fs/lockd/clntproc.c:17:
> > include/linux/sunrpc/svc.h: In function `svc_take_page': 
> > include/linux/sunrpc/svc.h:180: invalid lvalue in assignment
> > make[3]: *** [fs/lockd/clntproc.o] Error 1
> > make[2]: *** [fs/lockd] Error 2
> > make[1]: *** [fs] Error 2
> > make: *** [modules] Error 2
> 
> Looks like gcc fault, can You Pawel give as gcc version  ?

gcc-2.95.4-20010823

At least now it builds - I'll check later if it works :)

Thanks for your cooperation.

-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
