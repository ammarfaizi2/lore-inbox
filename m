Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVDEMq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVDEMq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 08:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVDEMq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 08:46:26 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:42448 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261718AbVDEMqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 08:46:22 -0400
Date: Tue, 5 Apr 2005 14:46:10 +0200
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Message-ID: <20050405124610.GA22308@gamma.logic.tuwien.ac.at>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050401113335.GA13160@elf.ucw.cz> <20050403224557.GB1015@gamma.logic.tuwien.ac.at> <20050403225929.GE13466@elf.ucw.cz> <20050404081600.GA2424@gamma.logic.tuwien.ac.at> <20050405100644.GA1345@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050405100644.GA1345@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 05 Apr 2005, Pavel Machek wrote:
> > It's b44. It *was* working with b44 insmod-ed and up and running, but
> > now as soon as b44-eth0 is ifup-ed while suspending, the resume freezes.
> > If I do a ifdown eth0 before suspending, it works.
> 
> Does this one help?

I compiled it into 2.6.12-rc2-mm1, and first wanted to try it with
module removed etc, but 2.6.12-rc2-mm1 not even freezes after resuming,
but immediately reboots!

So, more to track down. I will recreate my 2.6.12-rc1-mm4 tree, and try
your fix. Then I will try to find out *why* the hell 2.6.12-rc2-mm1 is
not resuming at all. Any ideas?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
QUENBY (n.)
A stubborn spot on a window which you spend twenty minutes trying to
clean off before discovering it's on the other side of the glass.
			--- Douglas Adams, The Meaning of Liff
