Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVD1JIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVD1JIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 05:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVD1JFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 05:05:16 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:15326 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261972AbVD1JEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 05:04:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [PATCH 6/6]suspend/resume SMP support
Date: Thu, 28 Apr 2005 11:04:37 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Li Shaohua <shaohua.li@intel.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com> <1114676961.26367.12.camel@sli10-desk.sh.intel.com> <20050428083459.GM1906@elf.ucw.cz>
In-Reply-To: <20050428083459.GM1906@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504281104.38702.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 28 of April 2005 10:35, Pavel Machek wrote:
> Hi!
> 
> > > But does setting CONFIG_ACPI_SLEEP cause kernel/power/smp.o to be actually
> > > compiled and linked?  I don't think so?
> > > 
> > > Anyway, please send a tested fix.
> > Ha, this one should be ok. Only IA32 support SMP suspend now.
> 
> Seems okay... Rafael, what is status of x86-64 smp swsusp?

Preliminary, semi-working. ;-)  Actually, I'm waiting for the i386 CPU hotplug
to settle down a bit to see how much of it I can use on x86-64.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
