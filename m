Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135749AbRECMMa>; Thu, 3 May 2001 08:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135950AbRECMMU>; Thu, 3 May 2001 08:12:20 -0400
Received: from ludwig-alpha.unil.ch ([192.42.197.33]:45985 "EHLO
	ludwig-alpha.unil.ch") by vger.kernel.org with ESMTP
	id <S135749AbRECMMF>; Thu, 3 May 2001 08:12:05 -0400
Message-Id: <200105031211.OAA23354@ludwig-alpha.unil.ch>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Alexandre Oliva <aoliva@redhat.com>
cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac3, asm problem in asm-i386/rwsem.h using gcc 3.0 CVS 
In-Reply-To: Message from Alexandre Oliva <aoliva@redhat.com> 
   of "03 May 2001 08:04:45 -0300." <org0em8zhu.fsf@guarana.lsd.ic.unicamp.br> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 14:11:58 +0200
From: Christian Iseli <chris@ludwig-alpha.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

aoliva@redhat.com said:
> I believe we'd need at least the source code of this function to be
> able to duplicate the problem with GCC.  Would you please submit a
> full bug report, following the guidelines at <URL:http://gcc.gnu.org/
> bugs.html>?  Thanks in advance, 

Ok, I filed a bug report to gcc-gnats, with pre-processed sources: `c/2728'

BTW, it is possible to compile sys.c with -O instead of -O2, and the problem 
is not triggered...

Cheers,
					Christian


