Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129440AbRCAM2j>; Thu, 1 Mar 2001 07:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129456AbRCAM23>; Thu, 1 Mar 2001 07:28:29 -0500
Received: from zeus.kernel.org ([209.10.41.242]:54236 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129440AbRCAM2Q>;
	Thu, 1 Mar 2001 07:28:16 -0500
Message-ID: <021b01c0a1b0$421eba80$2502a8c0@flyduck.flyduck.com>
From: "Lee Ho" <i@flyduck.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Collins, Tom" <Tom.Collins@Surgient.com>
Subject: Re: Multiple file module build problems
Date: Thu, 1 Mar 2001 02:59:54 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="euc-kr"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that linker tried to build executable file.
When building multiple module source into one module object file,
ld with '-r' option is used. 

ld -r -o scharmod.o schar.o procschar.o 

*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
Lee, Ho. Software Engineer, Embedded Linux Dep, LinuxOne 
Mail : flyduck@linuxone.co.kr (work), i@flyduck.com (personal)
Homepage : http://flyduck.com, http://linuxkernel.to

    Collins, Tom Wrote:
    
    
    I am trying to build a multiple-file kernel module, and am
    having some difficulty.  It seems that the linker is trying
    to build and executable.
    
    The link command is:
    
    ld -m elf_i386 -o scharmod.o schar.o procschar.o
    


