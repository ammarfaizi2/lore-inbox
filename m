Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267807AbTAHN4r>; Wed, 8 Jan 2003 08:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTAHN4r>; Wed, 8 Jan 2003 08:56:47 -0500
Received: from gherkin.frus.com ([192.158.254.49]:27520 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S267807AbTAHN4q>;
	Wed, 8 Jan 2003 08:56:46 -0500
Subject: XFree86 vs. 2.5.54 - reboot
To: linux-kernel@vger.kernel.org
Date: Wed, 8 Jan 2003 08:05:25 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030108140525.DF0434EE7@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This probably applies to immediately prior kernels in the 2.5 series
as well.  2.5.54 seemed like a good time to jump in and test the waters,
so to speak...

AMD K6-III 450 running a 2.4.19 kernel with vesafb, XFree86 4.1.0, and
a USB mouse works fine.  Same setup with a 2.5.54 kernel does a cold
reboot when I type "startx".  In both cases, the initial video state
is "vga=791" as set in /etc/lilo.conf.  As far as the crash, there's
no debug output of any kind in the logs to help narrow down the cause.

As best I can remember, the last time I had everything kinda working
with a 2.5.X kernel was prior to the introduction of the new module-init
tools.  This isn't a jab at Rusty et. al.  I'm merely trying to come up
with an approximate timeframe during which something changed which is
causing the problem.  The recent framebuffer driver changes probably
have something to with this issue.

If this is a known problem, would someone be kind enough to summarize
the discussion or let me know approximately when the discussion took
place so I can dig for it in the linux-kernel archives?  Thanks!

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
