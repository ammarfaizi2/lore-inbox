Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbTIDMdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbTIDMdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:33:12 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:35546 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S264976AbTIDMdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:33:10 -0400
Date: Thu, 4 Sep 2003 13:32:58 +0100
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Same problem with pcmcia in 2.4.22 as in 2.6.0-test4
Message-ID: <20030904123258.GA7674@iain-vaio-fx405>
Mail-Followup-To: kernel <linux-kernel@vger.kernel.org>
References: <1061936739.10642.6.camel@garaged.fis.unam.mx> <20030826223405.GA2746@iain-vaio-fx405> <20030831121019.GB22771@iain-vaio-fx405> <20030831133846.C3017@flint.arm.linux.org.uk> <20030902203043.GA12997@iain-vaio-fx405> <20030902224433.F9345@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902224433.F9345@flint.arm.linux.org.uk>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 13:31:09 up  1:20,  4 users,  load average: 0.40, 0.63, 1.24
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.8, required 5,
	BAYES_00 -5.20, IN_REP_TO -0.37, QUOTED_EMAIL_TEXT -0.38,
	REFERENCES -0.00, REPLY_WITH_QUOTES 0.00, USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King (rmk@arm.linux.org.uk) wrote:
> Could you try the updated debugging patch there please?  It should
> print something extra no matter what.
> 
> Could you also provide the kernel messages which include the
> initialisation of your PCMCIA or CardBus bridge please?

are these the right lines?

=======================================================================
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cs: request irq: pci irq 11 mask 0090
orinoco_cs: RequestIRQ: Resource in use
=======================================================================

that's from my boot sequence - I pulled and inserted the card and got
the last two lines again.

cheers,

iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine

"As for compromises: no. Free or fuck off." -- Andrew Suffield, on debian-legal
