Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265750AbSJTDXo>; Sat, 19 Oct 2002 23:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265752AbSJTDXo>; Sat, 19 Oct 2002 23:23:44 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:2432 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S265750AbSJTDXn>;
	Sat, 19 Oct 2002 23:23:43 -0400
Date: Sat, 19 Oct 2002 22:29:30 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: ide-cd locks up under 2.5.44
Message-ID: <Pine.LNX.4.44.0210192216420.891-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My hardware is an A7V133 with KT133 chipset, 82C686 southbridge, Athlon 
1.33 GHz processor.  System is RedHat 7.3-based.  

I've built 2.5.44 with ide-cd both built in and modular.  Any attempt to 
load the module, access a disk, or boot with ide-cd built in locks up the 
machine.  If I use modprobe, the modprobe process gets stuck in D state.  
In any of these cases I get an endless stream of:

Oct 19 21:27:35 dad kernel: hdc: irq timeout: status=0x90 { Busy }
Oct 19 21:27:35 dad kernel: hdc: irq timeout: 
error=0x01IllegalLengthIndication
Oct 19 21:28:05 dad kernel: hdc: ATAPI reset timed-out, status=0x80
Oct 19 21:28:05 dad kernel: ide1: reset: success




