Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280419AbRKNKhe>; Wed, 14 Nov 2001 05:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280433AbRKNKhZ>; Wed, 14 Nov 2001 05:37:25 -0500
Received: from elin.scali.no ([62.70.89.10]:21256 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S280430AbRKNKhL>;
	Wed, 14 Nov 2001 05:37:11 -0500
Subject: Re: Is this a kernel problem? segmentation fault
From: Terje Eggestad <terje.eggestad@scali.no>
To: dharter@lycos.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <IPKBFBEEDJJJACAA@mailcity.com>
In-Reply-To: <IPKBFBEEDJJJACAA@mailcity.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 14 Nov 2001 11:37:07 +0100
Message-Id: <1005734227.5852.0.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bugs in the kernel may cause seg fault, but when that happens you should
get an oops in /var/log/messages and/or on the console.

ons, 2001-11-14 kl. 02:40 skrev Donald Harter:
    I started by debugging this program where I was getting a segmentation  fault.  I used gdb and traced the bug to a call instruction.  I dissasembled  the code and stepped through the instructions.  The program  got a segmentation  fault when it executed an assembly language call instruction. Using gdb  I was able to disassemble the instructions at the called address. Why can  gdb disasemble instructions at a call address and a call to that address  fails with a segmentation fault?  Is this a kernel problem?  I am using kernel  version 2.2.15.  Any suggestions would be appreciated. I tried kernel 2.4.4  and the same thing happens.  I have searched this mailing list archive  and did find some posts about segmentation faults/ kernel bugs, but  they did not resolve this problem.  I use egcs 1.1-2 and ld 2.9.5 
    versions.
    
    
    
    -
    To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html
    Please read the FAQ at  http://www.tux.org/lkml/
    -- 
   
_________________________________________________________________________
    
    Terje Eggestad                  terje.eggestad@scali.no
    Scali Scalable Linux Systems    http://www.scali.com
    
    Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
    P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
    N-0621 Oslo                     fax:    +47 22 62 89 51
    NORWAY            
   
_________________________________________________________________________

