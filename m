Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTIIJEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 05:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263499AbTIIJEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 05:04:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5134 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263494AbTIIJEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 05:04:15 -0400
Date: Tue, 9 Sep 2003 10:04:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5: configcheck results
Message-ID: <20030909100412.A25143@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just ran make configcheck on 2.6.0-test5 and the results are:

    832 files need linux/config.h but don't actually include it.
    689 files which include linux/config.h but don't require the header.

This seems like a hell of a lot to fix.  Would it not just be easier to
use the -imacros or -include and eliminate the "do we need to include
linux/config.h" question for ever?

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
