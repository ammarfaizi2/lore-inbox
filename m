Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264424AbUFMALX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbUFMALX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 20:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUFMALW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 20:11:22 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:10644 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S264424AbUFMALT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 20:11:19 -0400
Subject: sys_close undefined on x86_64
From: John Stebbins <john@stebbins.name>
Reply-To: john@stebbins.name
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Home
Message-Id: <1087085478.7036.13.camel@Homer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 12 Jun 2004 17:11:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can someone tell me if this is a kernel bug or a problem with the module
I'm trying to compile?

I'm attempting to compile an external module for the PVR-250 mpeg-2
capture card (ivtv module).  The driver is a little behind the times,
but various people have persuaded it to compile and load on 2.6
systems.  I had it running on i386 arch 2.6 kernel earlier.  But I've
since upgraded to x86_64.

insmod fails with sys_close undefined message when attempting to load
the module.

The other sys_ functions seem to be there.

If the use of sys_close has been deprecated or something, could someone
please give me a pointer to the right way to do syscalls in the 2.6
kernels.  I've done some digging and just can't find any useful
information.

I'll be lurking on the kernel-list archives.

Thanks
John


