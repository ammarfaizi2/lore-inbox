Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTKTS1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTKTS1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:27:09 -0500
Received: from sow.visionpro.com ([63.91.95.5]:18440 "EHLO sow.visionpro.com")
	by vger.kernel.org with ESMTP id S262109AbTKTS1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:27:07 -0500
Message-ID: <F8E34394F337C74EA249580DEE7C240C111C28@chicken.machinevisionproducts.com>
From: Brian McGrew <brian@visionpro.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Upgrading Kernel kills X ...
Date: Thu, 20 Nov 2003 10:25:20 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

I have here a very weird situation which I'm hoping that someone can help me
resolve.  I'm running RedHat 9.0 on a Dell Poweredge 1600 server.  Now the
stock install of RedHat 9.0 gives me the 2.4.20-8(smp) kernels accordingly.
Now if I run RedHat's up2date and pull a new kernel from there, I'm fine.  

Where I run into problems, is two fold and this is where it gets confusing.
I have tried manually upgrading my kernel in a couple different ways.  The
first is that our company develops software for Linux (RedHat 7.3) and
therefor, we have a custom kernel package that we install as an RPM.  Works
great on RedHat 7.3 with this Dell PE1600.  The second method is installing
kernel source and building it myself (2.4-20 as well as 2.6.0-test9).  If I
build and install a kernel myself or add our typical rpm kernel, my X server
is toast.  Someone told me to double check that I have framebuffer support
turned on, so I did and that did not resolve the problem.

This box has an ATI Rage XL onboard video card, which typically uses the ATI
Mach64 driver.  Life is good with RedHat 7.3.  I can put our custom kernel
on the box or build and install new kernels all day long with no problems.
It's just that under RedHat 9.0, a non-RedHat kernel upgrade kills my
Xserver.  When it tries to start X, I get a signal 11.  Also, if I connect
to the machine from another host, set my display and try and run X with gdb
attached, even though there is no debug compiled in, I can see that
apperantly, X is dying in a function that looks like it's trying to probe
the PCI bus.

Any help would be great here.  If I have to call someone and pay for
support, just tell me who to call.  I need to get this fixed, hopefully by
the end of the day.

Thanks, best regards,


-brian

Brian D. McGrew {brian@visionpro.com || brian@doubledimension.com }
--
> My job is so secret ... I don't know what I do!

