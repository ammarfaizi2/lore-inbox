Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTKNKhd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 05:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTKNKhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 05:37:33 -0500
Received: from aun.it.uu.se ([130.238.12.36]:2747 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262395AbTKNKhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 05:37:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16308.44702.285989.900378@alkaid.it.uu.se>
Date: Fri, 14 Nov 2003 11:29:50 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NMI Watchdog
In-Reply-To: <Pine.LNX.4.44.0311141110420.22146-100000@gaia.cela.pl>
References: <Pine.LNX.4.44.0311141110420.22146-100000@gaia.cela.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski writes:
 > How do I go about getting the NMI Watchdog to work on a Celeron Mendocino
 > 400 MHz with no local APIC (nmi_watchdog=1/2 doesn't work, same kernel
 > works [/proc/interrupts show NMI's occuring 1/sec] on a 1GHz P3 with local
 > APIC)

The NMI watchdog requires a working local APIC.
So you can't, unless you upgrade the CPU.
