Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbTACUgo>; Fri, 3 Jan 2003 15:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267657AbTACUgo>; Fri, 3 Jan 2003 15:36:44 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:41358 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267656AbTACUgn>;
	Fri, 3 Jan 2003 15:36:43 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Meelis Roos <mroos@linux.ee>
Date: Fri, 3 Jan 2003 21:45:05 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.21-pre2+bk: matroxfb compile broken
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
X-mailer: Pegasus Mail v3.50
Message-ID: <C349ADE6470@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Jan 03 at 22:18, Meelis Roos wrote:
> matroxfb_base.c: In function `matroxfb_ioctl':
> matroxfb_base.c:1231: `MATROXFB_TVOQUERYCTRL' undeclared (first use in this function)
> matroxfb_base.c:1231: (Each undeclared identifier is reported only once
> matroxfb_base.c:1231: for each function it appears in.)
> matroxfb_base.c:1233: storage size of `qctrl' isn't known
> matroxfb_base.c:1233: warning: unused variable `qctrl'
> matroxfb_base.c:1253: `MATROXFB_G_TVOCTRL' undeclared (first use in this function)
> matroxfb_base.c:1255: storage size of `ctrl' isn't known
> matroxfb_base.c:1255: warning: unused variable `ctrl'
> matroxfb_base.c:1275: `MATROXFB_S_TVOCTRL' undeclared (first use in this function)
> matroxfb_base.c:1277: storage size of `ctrl' isn't known
> matroxfb_base.c:1277: warning: unused variable `ctrl'
> 
> This is current BK on x86, matroxfb as module.

Probably patch to include/linux/matroxfb.h was missed by Marcelo
(or Alan). Try using include/linux/matroxfb.h from 2.4.20-ac2.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
