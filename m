Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbTDIPxl (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbTDIPxl (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:53:41 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:2196 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S263548AbTDIPxk (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 11:53:40 -0400
Subject: 2.5.67, 2.5-bk lock up with RH 9 and graphical log out.
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049904293.24463.25.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 09 Apr 2003 10:04:53 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this should be considered a Red Hat problem or a kernel
problem, but here it is anyway.

With kernel 2.5.67 or 2.5-bk-current and Red Hat 9, if I try to do a
graphical log out from either KDE or Gnome, the test machine locks up
hard, not responding to pings, or alt-sysrq-anything. (and yes,
/proc/sys/kernel/sysrq is 1 and I "fixed" /etc/sysctl.conf, line 13)

The same lockup happens with ctrl-alt-backspace from KDE or Gnome.

Doing an /sbin/init 3 works fine.  Harsh way to log out however.
Subsequent cycles of startx and graphical "Log Out" do _not_ lock up
the box, but work just fine.

Needless to say, with the vendor kernel, everything works perfectly. 
Alt-sysrq-various behaves as expected. Ctrl-alt-backspace does not
lock up the box.

If I get time, I'll try some older 2.5.x kernels to see if this is a
recently introduced behavior.

Steven


