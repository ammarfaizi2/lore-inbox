Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261632AbSI0FeI>; Fri, 27 Sep 2002 01:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261633AbSI0FeI>; Fri, 27 Sep 2002 01:34:08 -0400
Received: from host187.south.iit.edu ([216.47.130.187]:8577 "EHLO
	host187.south.iit.edu") by vger.kernel.org with ESMTP
	id <S261632AbSI0FeH>; Fri, 27 Sep 2002 01:34:07 -0400
Date: Fri, 27 Sep 2002 00:38:16 -0500 (CDT)
From: Stephen Marz <smarz@host187.south.iit.edu>
To: linux-kernel@vger.kernel.org
Subject: USB Mass Storage Hangs
Message-ID: <Pine.LNX.4.44.0209270035080.3034-100000@host187.south.iit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message regards the USB mass storage driver for kernel version
2.4.18-10:

On my Dell Inspiron 7500 I have an adaptec USB 2.0 cardbus
adapter.  I plugged in a 120GB hard drive and the mass
storage driver in linux detects it and runs it fine.  The
problem comes in when I try to also plug in my CD-RW into
the cardbus adapter (it has two USB 2.0 ports).  The mass
storage driver will detect and gather information about
the drive, however it doesn't take more than two or
three minutes before the entire system hangs.  The kernel
immediately drops all knowledge of any USB device on
my system.

Anybody else notice this problem?


Thanks,

Stephen Marz

