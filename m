Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264327AbTEZJtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 05:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTEZJtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 05:49:17 -0400
Received: from snoopy.pacific.net.au ([61.8.0.36]:48057 "EHLO
	snoopy.pacific.net.au") by vger.kernel.org with ESMTP
	id S264327AbTEZJtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 05:49:16 -0400
Date: Mon, 26 May 2003 20:01:50 +1000
From: Andrew Steele <fozzy@zip.com.au>
To: mec@shout.net
Cc: linux-kernel@vger.kernel.org
Subject: Menuconfig abort error report with mdk 9.1 +skas patch
Message-ID: <20030526100150.GC29649@zipworld.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to build a kernel using the kernel source from Mandrake 9.1

When I try and go into the ALSA selection off the sound menu
menuconfig aborts with the following message:

-------------------------------------------------------------------

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu71: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1

-------------------------------------------------------------------

This is a standard Mandrake 9.1 kernel (which I realise isn't really
that "standard").  The only patching I've done to it is apply the User
Mode Linux SKAs patch.

I hope this is helpful to you.

Thanks
Andrew
