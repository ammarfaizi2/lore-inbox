Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbSIPSkW>; Mon, 16 Sep 2002 14:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSIPSkW>; Mon, 16 Sep 2002 14:40:22 -0400
Received: from host-65-162-110-4.intense3d.com ([65.162.110.4]:2822 "EHLO
	exchusa03.intense3d.com") by vger.kernel.org with ESMTP
	id <S262785AbSIPSkV>; Mon, 16 Sep 2002 14:40:21 -0400
Message-ID: <23B25974812ED411B48200D0B77407170133CBFD@exchusa03.intense3d.com>
From: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
To: linux-kernel@vger.kernel.org
Subject: Debugging modules with kgdb - single stepping issues
Date: Mon, 16 Sep 2002 13:45:13 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not sure if kernel debugger issues are inappropriate on this 
list, but I'd think most of you would have used kgdb at one time 
or another.

I have a kgdb setup (kernel 2.4.18-5 patched with the 2.4.18 kgdb) 
and I'm debugging a module.   I notice that I can add break points,
and stop execution, however I'm not able to step into the code.
The module has been compiled with gdb symbols (-g).  I've used the 
loadmodule.sh script to load the module.  I'm using the gdb (5.2.1).

One thing to note though, is I'm debugging a DRM kernel module which 
resides it's own Xfree tree.  But it's a kernel module and I don't believe 
that should be the problem.

Any thoughts?  What am I missing?  I'd appreciate any suggestions!

Please CC your replies as I'm not subscribed to the list. 

Thanks,
Bhavana
