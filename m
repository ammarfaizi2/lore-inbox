Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267728AbSLGACf>; Fri, 6 Dec 2002 19:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267730AbSLGACf>; Fri, 6 Dec 2002 19:02:35 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:51372 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267728AbSLGACe>; Fri, 6 Dec 2002 19:02:34 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: acpi-devel@sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Proposed ACPI Licensing change
Date: Fri, 6 Dec 2002 16:10:00 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The ACPI AML interpreter (i.e. code in directories under drivers/acpi, but
not source in drivers/acpi directly) has been released by us (Intel) under
the GPL. It has also been released separately under a looser license, so
that other OS vendors may make use of it.

One consequence of this is that we have not been able to benefit directly
from patches from other Linux contributors. The reason is, patches submitted
to code only under the GPL must also be GPL, and therefore we cannot take
them directly and still make our code available under a license other than
the GPL. (We have to determine the problem the patch fixes and then do the
fix ourselves.)

This has slowed development and lessened community participation in the
development process.

In order to solve this, we are considering releasing the Linux version of
the interpreter under a dual license. This would allow direct incorporation
of changes. Any patches submitted against the ACPI core code would
implicitly be allowed to be used by us in a non-GPL context. This is already
done elsewhere in the Linux kernel source by the PCMCIA code, for example.

Comments?

Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

