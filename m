Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBJW3K>; Sat, 10 Feb 2001 17:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbRBJW2v>; Sat, 10 Feb 2001 17:28:51 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:60421 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129027AbRBJW2l>; Sat, 10 Feb 2001 17:28:41 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE02F@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Hasan Abbasi'" <u970066@giki.edu.pk>, linux-kernel@vger.kernel.org
Subject: RE: Unresolved Symbol error
Date: Sat, 10 Feb 2001 14:28:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to create a catcher module that will provide a 
> distributed layer over the file system. To do this I am using 
> a kernel module to intercept and pre process the open system 
> call. However I need to use some functions such as strlen() 
> and memcpy() etc. When I try to compile the module it 
> compiles fine. Without any errors. However when I insert the 
> module using insmod <module name> I get an error:
> catcher.o: unresolved symbol strlen
> 
> I am compiling the module using -D__KERNEL__ -DMODULE -DLINUX 
> options. Is there some thing else that I have to do to use 
> the strlen function. 

Also use -O2 .

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
