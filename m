Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTHVVGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbTHVVGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:06:12 -0400
Received: from [63.193.79.19] ([63.193.79.19]:22919 "HELO mwg.inxservices.lan")
	by vger.kernel.org with SMTP id S264240AbTHVVGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:06:06 -0400
Date: Fri, 22 Aug 2003 14:05:55 -0700
From: George Garvey <tmwg-linuxknl@inxservices.com>
To: linux-kernel@vger.kernel.org
Subject: Intel 865 AGP and nVidia driver problem
Message-ID: <20030822210555.GX1437@inxservices.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: inX Services, Los Angeles, CA, USA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Just bought a new computer, Intel D865PERL motherboard, one P4 SMP
w/HT. When starting X in both 2.6.0-test3 and 2.4.22-rc2 with pre7-aa1,
screen goes black and system is gone (fortunately system keys to unmount
and reboot work). Last line in X log shows MMIO registers, but could
have gotten further and just not on disk.
   Does anyone have a suggestion? Or another graphics card that isn't
proprietary that will drive a Sony GDM-FW900 at 2304x1440 DPI (30-121
kHz hor, 48-160 Hz ver)?
   Not sure what to provide, but will send config, dmesg, anything that
will assist. Have a suspicion it may just be that the AGP is new and the
nVidia driver doesn't know how to use it, but that may be completely off
base.
   Using GCC 3.3.1 with -march=pentium4.
