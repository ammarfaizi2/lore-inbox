Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbTCPALC>; Sat, 15 Mar 2003 19:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261813AbTCPALC>; Sat, 15 Mar 2003 19:11:02 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50313 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261808AbTCPALB>;
	Sat, 15 Mar 2003 19:11:01 -0500
Message-Id: <200303152313.h2FNDv3A008825@eeyore.valparaiso.cl>
To: "sean darcy" <seandarcy@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-bk9 -- vfat32 fails 
In-Reply-To: Your message of "Sat, 15 Mar 2003 12:51:50 EST."
             <F52RDT6Z3LstPGtPrPr000001a9@hotmail.com> 
Date: Sat, 15 Mar 2003 19:13:57 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"sean darcy" <seandarcy@hotmail.com> said:
> I'm getting this error on a large vfat partition:
> 
> lsattr /win/photo/scanner.test
> lsattr: Inappropriate ioctl for device While reading flags on 
> /win/photo/scanner.test/frame4-atTableSep02.psd
> lsattr: Inappropriate ioctl for device While reading flags on 
> /win/photo/scanner.test/frame2-atTableSep02.psd
> 
> I found this because I couldn't create a soft link (ln -s ) on the 
> partition. FWIW, ls -l does not show a problem.

VFAT has no way to represent a symbolic link, so an error is just to be
expected. Perhaps the wording isn't optimal.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
