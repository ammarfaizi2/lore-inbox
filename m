Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbSJUWU6>; Mon, 21 Oct 2002 18:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbSJUWU6>; Mon, 21 Oct 2002 18:20:58 -0400
Received: from h-64-105-137-32.SNVACAID.covad.net ([64.105.137.32]:14504 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261718AbSJUWU5>; Mon, 21 Oct 2002 18:20:57 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 21 Oct 2002 15:26:31 -0700
Message-Id: <200210212226.PAA01409@adam.yggdrasil.com>
To: ebiederm@xmission.com, mochel@osdl.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote to Eric Biederman:
>        kmonte and sys_kexec skip the BIOS reset code and therefore
>may need to do more elaborate shutdown, but please do not saddle the
>normal reboot case with [that].

	Let me add that I would be quite happy to see the common code
in sys_reboot moved into a shared exported routine that sys_kexec and
kmonte could use, so that they would automatically track changes to
that procedure rather than requiring maintenance of a duplicate copy
of that code.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


