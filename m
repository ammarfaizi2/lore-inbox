Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbRERIMx>; Fri, 18 May 2001 04:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbRERIMn>; Fri, 18 May 2001 04:12:43 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:61202 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S262272AbRERIMc>;
	Fri, 18 May 2001 04:12:32 -0400
Date: Fri, 18 May 2001 10:12:27 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux 2.4.4-ac10
To: alan@lxorguk.ukuu.org.uk
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B04D96B.FCDA69E9@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox (alan@lxorguk.ukuu.org.uk) wrote :

> > 
> > gcc -D__KERNEL__ -I/usr/src/linux-2.4.4-ac/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -c -o apm.o apm.c 
> > {standard input}: Assembler messages: 
> > {standard input}:180: Warning: indirect lcall without `*' 
> > {standard input}:274: Warning: indirect lcall without `*' 
> > 
> > Does anyone know what's up with that? Kernel problem or binutils issue? 
> 
> binutils is issuing a correct warning but if we fix the warning old old binutils 
> will then refuse to assemble it right. 

What old old binutils ?
Isn't there a clear requirement for a minimum binutils version in
Documentation/Changes ( or maybe it is README ... ) ?

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
