Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280780AbRKBSm0>; Fri, 2 Nov 2001 13:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280778AbRKBSmS>; Fri, 2 Nov 2001 13:42:18 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:33798 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S280777AbRKBSly>;
	Fri, 2 Nov 2001 13:41:54 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Keith Owens <kaos@ocs.com.au>
Date: Fri, 2 Nov 2001 19:41:20 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Oops on 2.4.13 
CC: LKML <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <80D353813B1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Nov 01 at 13:02, Keith Owens wrote:

> drivers/video/matrox/matroxfb_crtc2.o - no license, needs patch
> drivers/video/matrox/matroxfb_g450.o - no license, needs patch
> drivers/video/matrox/matroxfb_maven.o - no license, needs patch
> drivers/video/matrox/matroxfb_misc.o - no license, needs patch

They are all GPL-ed. Does it mean that I have to fix that someone
else changed kernel API during stable serie?
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
P.S.: I still do not understand this MODULE_LICENSE() thing. VMware
modules will probably contain GPL tag in next release, but kernel 
hackers refuse to look at these reports anyway (I'm not complaining,
this is their right to ignore these reports; but if they say that they 
are doing that due to non-GPL, they lie). So I think it should be changed 
from MODULE_LICENSE() to 
MODULE_CERTIFIED_BY_LINUX_KERNEL_WORKING_GROUP("xxx says it works"). 
It would match real meaning much better.
