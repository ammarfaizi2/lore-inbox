Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTCCLV2>; Mon, 3 Mar 2003 06:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTCCLV2>; Mon, 3 Mar 2003 06:21:28 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:32676 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262806AbTCCLV1>;
	Mon, 3 Mar 2003 06:21:27 -0500
Date: Mon, 3 Mar 2003 12:31:53 +0100
From: bert hubert <ahu@ds9a.nl>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Roger Luethi <rl@hellgate.ch>, Pavel Machek <pavel@ucw.cz>,
       Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303113153.GA18563@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Roger Luethi <rl@hellgate.ch>, Pavel Machek <pavel@ucw.cz>,
	Andrew Grover <andrew.grover@intel.com>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046657290.8668.33.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 03:08:11PM +1300, Nigel Cunningham wrote:

> > The only thing that came up at the time was a suggestion to replace BUG_ON
> > with while (which I didn't try because I'd like to keep my data).
> 
> I'll see if I can find a solution.

A data point may be that at one point, swsusp did work just fine for me.
This was around 2.5.53, 2.5.54:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=20021227142032.GA6945%40outpost.ds9a.nl&rnum=1&prev=/groups%3Fq%3Dswsusp%2Bbert%2Bhubert%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26selm%3D20021227142032.GA6945%2540outpost.ds9a.nl%26rnum%3D1

I now use gcc 3.2.2 for compiling though. I've tried suspending a few times
with 2.5.63bk5 and I get the BUG every time, so it appears to be
deterministic and not racey.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
