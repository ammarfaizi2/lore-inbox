Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWHDFCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWHDFCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHDFC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:02:29 -0400
Received: from fsmlabs.com ([168.103.115.128]:1999 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751385AbWHDFC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:02:29 -0400
From: Cort Dougan <cort@hq.fsmlabs.com>
Date: Thu, 3 Aug 2006 23:02:00 -0600
To: linux-kernel@vger.kernel.org
Cc: zwane@fsmlabs.com
Subject: automated Linux Regression suite
Message-ID: <20060804050200.GA22923@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw the talk by Greg Kroah-Hartman at
http://www.kroah.com/log/linux/ols_2006_keynote.html and wanted to correct
a mistake (perhaps itself a myth).

A regression suite, fully automated, has existed for Linux since I was
running the PPC tree in the 90's.  I still use an extensive and very much
upgraded version here at FSMLabs.  There will be a C/C++ Journal article on
it in the next few months but there is a link describing it and how to
re-implement it here:

http://www2.fsmlabs.com/~cort/papers/sparky/sparky.pdf
http://www2.fsmlabs.com/~cort/papers/sparky/sparky.nohead.html

It tests FreeBSD, NetBSD and Linux for PowerPC, x86, x86-64, FRV, MIPS, 
ARM, XScale and IXP.  It tests user-land, kernel functionality, RTLinux and
RTCore along with all of our realtime drivers.

To this day we're expanding it's coverage and capability.  It took one long
weekend to write the first version of this system.
