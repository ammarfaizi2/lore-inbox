Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313797AbSDPSAP>; Tue, 16 Apr 2002 14:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313798AbSDPSAO>; Tue, 16 Apr 2002 14:00:14 -0400
Received: from dragon.flightlab.com ([206.169.119.102]:13064 "EHLO
	dragon.flightlab.com") by vger.kernel.org with ESMTP
	id <S313797AbSDPSAN>; Tue, 16 Apr 2002 14:00:13 -0400
Message-Id: <200204161800.g3GI06f22193@dragon.flightlab.com>
To: linux-kernel@vger.kernel.org
Subject: MODULE_LICENSE string for LGPL drivers?
Date: Tue, 16 Apr 2002 11:00:06 -0700
From: Joe English <jenglish@flightlab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

What should I use for the MODULE_LICENSE() string in a driver
that is distributed under the LGPL?  "LGPL" isn't listed in
include/linux/module.h as an "untainted" license, so should I
use "GPL and additional rights" instead?

I don't *think* I'm running into problems with EXPORT_SYMBOL_GPL --
the driver has been working fine under 2.4 kernels
and I only recently found out about MODULE_LICENSE and
*that* whole mess -- but am not sure, since I've also
got an older version of modutils which probably isn't
performing the taint check.

Unfortunately switching to the GPL is not an option;
the driver was written for a third party and must be
distributed with firmware (proprietary, binary-only)
and client libraries (source available but still proprietary)
over whose license terms I have no control.

Alternately, I could just let it taint the kernel.


Thanks for any advice.  Cc:'s to jenglish@flightlab.com
will be appreciated; I am not subscribed to this list, but
will try to keep up via the web archives.


--Joe English

  jenglish@flightlab.com
