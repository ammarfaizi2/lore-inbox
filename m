Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbUKWC4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbUKWC4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUKWCzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:55:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26595 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261861AbUKWCva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:51:30 -0500
Date: Mon, 22 Nov 2004 21:50:04 -0500
From: Dave Jones <davej@redhat.com>
To: Len Brown <len.brown@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: why use ACPI (Re: 2.6.10-rc2 doesn't boot (if no floppy device))
Message-ID: <20041123025004.GM17249@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Len Brown <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>,
	Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de> <1101148138.20008.6.camel@d845pe> <20041123004619.GQ19419@stusta.de> <1101172056.20006.153.camel@d845pe> <20041123013720.GA4371@stusta.de> <1101178052.20007.196.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101178052.20007.196.camel@d845pe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 09:47:32PM -0500, Len Brown wrote:
 > > > Also, CPUFREQ usually often on ACPI, and that can save
 > > > power even when the system is not idle, and this results
 > > > in lower temperatures and hopefully slower fan speeds.
 > > 
 > > My computer has a desktop Athlon...
 > 
 > maybe Dave can determine if there is a governor that can help you.
 > 
 > cheers,
 > -Len

desktop athlons tend not to have powernow. And those that do
(usually by someone transplanting a mobile part into a desktop
 board), hit the problem where the BIOS has no idea what the
hell is going on, and sets up no PST tables.

		Dave

