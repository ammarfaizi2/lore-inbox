Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVBQXag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVBQXag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBQX2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:28:51 -0500
Received: from gprs214-47.eurotel.cz ([160.218.214.47]:56216 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261242AbVBQX2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:28:08 -0500
Date: Fri, 18 Feb 2005 00:27:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: vojtech@suse.cz, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3 (fwd)
Message-ID: <20050217232719.GB12638@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry, I was too fast with my  mail client. Please cc: Len in your
replies.


To: Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] Call for help: list of machines with working S3
X-Warning: Reading this can be dangerous to your mental health.

Hi!

> > I'm not sure if you can push the whole industry at once.
> 
> The goal is to know what to tell the system vendors
> interested in supporting Linux what they should do
> with their BIOS on future platforms.
> 
> I believe our message should be:
> 1. BIOS should save/restore video in S3

Actually, that'd expect too much of BIOS writers. I believe right
solution is "POST video as you do during normal boot in S3 resume".

> 2. Use Intel's ACPICA ASL compiler -- if not for production,
> then at least as a static source code checker for validation.

3. Try to boot linux (here's live cd). If it complains about bios bugs
(dmesg | grep ...), try to see if it is not indeed your bug.
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

----- End forwarded message -----

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
