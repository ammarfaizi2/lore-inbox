Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSCRNoZ>; Mon, 18 Mar 2002 08:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310828AbSCRNoP>; Mon, 18 Mar 2002 08:44:15 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:7955 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S310825AbSCRNoK>; Mon, 18 Mar 2002 08:44:10 -0500
Message-Id: <200203181341.g2IDfbq28679@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dave Jones <davej@suse.de>
Subject: Re: [-ENOCOMPILE] ataraid as module in linux-2.5.7-pre2
Date: Mon, 18 Mar 2002 15:41:10 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203180938.g2I9c1q27846@Port.imtp.ilyichevsk.odessa.ua> <20020318142240.D3025@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 March 2002 11:22, Dave Jones wrote:
> On Mon, Mar 18, 2002 at 11:37:33AM -0200, Denis Vlasenko wrote:
>  > gcc -D__KERNEL__ -I/.share/usr/src/linux-2.5.7-pre2/include -Wall
>  > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
>  > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
>  > -march=i386 -DMODULE -DMODVERSIONS -include
>  > /.share/usr/src/linux-2.5.7-pre2/include/linux/modversions.h
>  > -DKBUILD_BASENAME=ataraid  -DEXPORT_SYMTAB -c ataraid.c
>
>  Yup, this, the Raid5 report, and a few other non-compiling bits
>  are logged at http://www.codemonkey.org.uk/Linux-2.5.html
>
>  If there's no change in those files between pre's, re-reporting
>  the same non-compile errors probably isn't going to get them fixed
>  any quicker 8-)

I didn't mean "hey it's broken, _fix _them _for _me_".
I don't use any of these things, I'll disable them in .config
and that's all.

Should I restrain from posting compile errors for 2.5?
--
vda
