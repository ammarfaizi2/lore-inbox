Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277395AbRJVBOh>; Sun, 21 Oct 2001 21:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277398AbRJVBO2>; Sun, 21 Oct 2001 21:14:28 -0400
Received: from ausxc08.us.dell.com ([143.166.99.216]:32357 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S277395AbRJVBOR>; Sun, 21 Oct 2001 21:14:17 -0400
Message-ID: <71714C04806CD51193520090272892178BD766@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: todd@unm.edu
Cc: linux-kernel@vger.kernel.org
Subject: RE: 50MB kernel on ia64??
Date: Sun, 21 Oct 2001 20:14:44 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> now i've got another problem:  kernels built with the 
> attached .config (or
> anything even vaguely similar--this one is for 2.4.7) are 
> around 50MB in size!

You've got the gcc -g option specified in the Makefile.  'strip
--strip-debug' your kernel and it'll shrink considerably, or remove the -g.

> morevover, there's no vmlinux or bzImage target in the makefile
> once ia64 is selected as the architecture.  

make compressed

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!
