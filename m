Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVDDIQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDDIQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVDDIQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:16:22 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:20608 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261169AbVDDIQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:16:07 -0400
Date: Mon, 4 Apr 2005 10:16:00 +0200
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Message-ID: <20050404081600.GA2424@gamma.logic.tuwien.ac.at>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050401113335.GA13160@elf.ucw.cz> <20050403224557.GB1015@gamma.logic.tuwien.ac.at> <20050403225929.GE13466@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050403225929.GE13466@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel!

On Mon, 04 Apr 2005, Pavel Machek wrote:
> I'd like to fix the problem, but first I need to know where the
> problem is.  If it works with minimal config, I know that it is one of
> drivers you deselected.

It's b44. It *was* working with b44 insmod-ed and up and running, but
now as soon as b44-eth0 is ifup-ed while suspending, the resume freezes.
If I do a ifdown eth0 before suspending, it works.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
PUDSEY (n.)
The curious-shaped flat wads of dough left on a kitchen table after
someone has been cutting scones out of it.
			--- Douglas Adams, The Meaning of Liff
