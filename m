Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWCCQxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWCCQxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWCCQxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:53:05 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:55184 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932273AbWCCQxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:53:01 -0500
Date: Fri, 3 Mar 2006 16:51:19 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>,
       Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de,
       mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions
Message-ID: <20060303165119.GA30228@srcf.ucam.org>
References: <3ACA40606221794F80A5670F0AF15F840B0CE273@pdsmsx403> <E1FF0Vm-0002Fl-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FF0Vm-0002Fl-00@skye.ra.phy.cam.ac.uk>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 02:59:22AM +0000, Sanjoy Mahajan wrote:

> I'll try it, although I don't think I'll get any data on the problem.
> The unmodified DSDT (bios 1.11) lacks an S3 sleep object, so I had to
> modify the DSDT even to get S3 to sleep at all.  See
> <http://bugzilla.kernel.org/show_bug.cgi?id=3534> for that discussion.

I think it's arguably a bit extreme to describe "My setup is so 
unsupported that I had to modify my firmware to enable sleep and then 
override the kernel's sanity checks and it's stopped working with 
2.6.16" as a regression.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
