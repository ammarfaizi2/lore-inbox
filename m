Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbTHCTLR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 15:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269191AbTHCTLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 15:11:17 -0400
Received: from sc-outsmtp1.homechoice.co.uk ([81.1.65.35]:25349 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S269133AbTHCTLQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 15:11:16 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: linux-sh@m17n.org
Subject: Cross compiling strangeness (EXTRAVERSION oddness)
Date: Sun, 3 Aug 2003 20:11:22 +0100
User-Agent: KMail/1.4.3
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200308032011.22631.adrian@mcmen.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anybody else seen this problem? Is it me or is it generic?

I am building 2.6.0-test2 on an ia32 box for use on an SH box (Dreamcast).

I am now building some modules (I am trying to write an ALSA module for the 
Dremcast's sound card) and when I use make ... modules_install, it installs 
them to the /lib/modules/2.6.0-test2-sh heirarchy as it should.

However, the running kernel, build with the same tools and often at the same 
time, thinks its a plain vanilla 2.6.0-test2 kernel and so tries to load 
modules from /lib/modules/2.6.0-test2.

Adrian
