Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbSLOHH2>; Sun, 15 Dec 2002 02:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSLOHH2>; Sun, 15 Dec 2002 02:07:28 -0500
Received: from pony.its.uwo.ca ([129.100.2.63]:10488 "EHLO pony.its.uwo.ca")
	by vger.kernel.org with ESMTP id <S266256AbSLOHH1>;
	Sun, 15 Dec 2002 02:07:27 -0500
To: linux-kernel@vger.kernel.org
Subject: suspend to ram problems on Dell I4150 with Radeon 7500
From: Dan Christensen <jdc@uwo.ca>
Date: Sun, 15 Dec 2002 01:15:03 -0500
Message-ID: <87vg1vst94.fsf@uwo.ca>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please cc me on replies.]

I have a Dell Inspiron 4150 laptop with a 32M Radeon Mobility M7 LW
rev 0.  When I suspend to ram, the screen "melts" to all white and
stays that way while the machine is suspended.  When I resume, all is
well.

Nobody else on the linux-dell-laptops list seems to be having this
problem, even people with what appears to be the same hardware.  It
happens with my custom kernels (I've tried 2.4.19 and 2.4.20) and the
stock Debian 2.4.19 (all with apm, not acpi).  All three of these
kernels work correctly on other I4100 and I4000 machines I have access
to.  Suspend to ram works fine under Windows on the I4150.

The problem happens even if I shut down X windows and rmmod the radeon
and agpgart modules before suspending.

I'd like to try to debug this.  What further information can I provide?

Thanks,

Dan

-- 
Dan Christensen
jdc@uwo.ca
