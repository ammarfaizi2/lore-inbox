Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUH2EVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUH2EVN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 00:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUH2EVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 00:21:13 -0400
Received: from kludge.physics.uiowa.edu ([128.255.33.129]:15877 "EHLO
	kludge.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S261234AbUH2EVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 00:21:10 -0400
Date: Sat, 28 Aug 2004 23:20:38 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: Problem reading /proc/acpi/battery/BAT0/info
Message-ID: <20040829042038.GA8073@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm writing some code to read battery status, but am having problems reading
  /proc/acpi/battery/BAT0/info.
If I read that file, I can fill *one* and *only one* buffer before I get
  EOF (read returns 0 bytes read on the next buffer).  This is regardless
  of buffer length--I can use 1 or 3 or 10 bytes.  First read succeeds,
  second read fails.  Errno is 0.
With the *same code*, I can read the entire file without issue.
Any hints as to what's going on here?
Thanks!

Puzzled,
-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer
