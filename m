Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbTJUWdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbTJUWdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:33:41 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:50056
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S263307AbTJUWdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:33:40 -0400
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.0: Does software suspend have a chance of working with X in native mode??
Message-Id: <E1AC54Z-0006Ao-00@penngrove.fdns.net>
Date: Tue, 21 Oct 2003 15:33:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that the X utilizing the VESA driver works with software suspend, 
but the i830 DRI driver fails miserably (double-faults or auto-reboots) 
for me and others upon resuming.

Does DRI have any chance of working with software suspend???  If not,
what X drivers might be suitable?

At the moment, i'm stuck with 256 colors on a Sony VAIO R505EL, as
it appears that 'vesafb' is stuck with whatever 'arch/i386/boot/video.S' 
is able to set up and nothing i've tried so far doing to 'video.S' has
allowed me to get past that.  I've also tried the framebuffer driver for 
i830 under 2.4.21, but it has the same limitation as 'vesafb'.

				  -- JM

P.S.  I have the Intel i830 documentation (245 pages of register level
details), so in principle some kind of driver could be written, but i
know next to nothing about PCI or AGP, or for that matter, the LINUX 
framebuffer architecture.
