Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTILJ3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbTILJ3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:29:09 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:20449 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S261332AbTILJ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:29:07 -0400
Date: Fri, 12 Sep 2003 10:28:50 +0100
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: lkml <linux-kernel@vger.kernel.org>
Subject: pcmcia still borked in test5
Message-ID: <20030912092849.GB2921@iain-vaio-fx405>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8, required 5,
	BAYES_00 -5.20, USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

	cs: IO port probe 0x0c00-0x0cff: clean.
	cs: IO port probe 0x0800-0x08ff: clean.
	cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df
	0x4d0-0x4d7
	cs: IO port probe 0x0a00-0x0aff: clean.
	cs: memory probe 0xa0000000-0xa0ffffff: clean.
	cs: request irq: pci irq 11 mask 0090
	orinoco_cs: RequestIRQ: Resource in use

	is what i get on test5 with the second IRQ patch from
	pcmcia.arm.

	cheers,

	iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine
