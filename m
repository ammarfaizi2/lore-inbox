Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFBmM>; Fri, 5 Jan 2001 20:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRAFBmC>; Fri, 5 Jan 2001 20:42:02 -0500
Received: from jelerak.scrye.com ([207.174.18.194]:4369 "HELO scrye.com")
	by vger.kernel.org with SMTP id <S129324AbRAFBl6>;
	Fri, 5 Jan 2001 20:41:58 -0500
Message-ID: <20010106014150.1324.qmail@scrye.com>
Date: Fri, 5 Jan 2001 18:41:50 -0700 (MST)
From: Kevin Fenzi <kevin@scrye.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: X and 2.4.0 problem (video bios probing?) (more info)
In-Reply-To: <E14Ee3z-0008R6-00@the-village.bc.nu>
In-Reply-To: <20010105210016.1778.qmail@scrye.com>
	<E14Ee3z-0008R6-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> (II) Loading /usr/X11R6/lib/modules/linux/libint10.a (II) Module
>> int10: vendor="The XFree86 Project" compiled for 4.0.1a, module
>> version = 1.0.0 ABI class: XFree86 Video Driver, version 0.2 (EE)
>> ATI(0): Unable to initialise int10 interface.

Alan> Thats the critical bit but it isnt directly a kernel thing. Im
Alan> not sure why it should have failed. Do you have different
Alan> .config options (eg ATI fb options ?)

By the process of elimination, I have determined that my problem
appears in the 2.4.0-test13-pre3 patch. 

2.4.0-test13-pre2 X works fine, in pre3 and beyond it fails. 

Anyone able to spot anything in the pre3 patch that might be causing
this? 

thanks, 

kevin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
