Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAEVJE>; Fri, 5 Jan 2001 16:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRAEVIy>; Fri, 5 Jan 2001 16:08:54 -0500
Received: from jelerak.scrye.com ([207.174.18.194]:47886 "HELO scrye.com")
	by vger.kernel.org with SMTP id <S129561AbRAEVIl>;
	Fri, 5 Jan 2001 16:08:41 -0500
Message-ID: <20010105210831.2001.qmail@scrye.com>
Date: Fri, 5 Jan 2001 14:08:31 -0700 (MST)
From: Kevin Fenzi <kevin@scrye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X and 2.4.0 problem (video bios probing?)
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

nope. I did do a 'make oldconfig' after patching to 2.4.0 (final), but
all the other options are the same. 

I was not using the ATI fb in either case. I had it built as a module,
"ATI Rage 128 display support (EXPERIMENTAL)" (that I didn't load)
and I did have "VESA VGA graphics console" enabled. 

kevin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
