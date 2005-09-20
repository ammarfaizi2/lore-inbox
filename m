Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVITVJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVITVJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVITVJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:09:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4821 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965121AbVITVJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:09:19 -0400
Date: Tue, 20 Sep 2005 23:06:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com,
       Pierre Ossman <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-ID: <20050920210617.GA1779@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com> <m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0509111140550.9218@math.ut.ee> <m14q8fhc02.fsf_-_@ebiederm.dsl.xmission.com> <m1zmq7fx3v.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zmq7fx3v.fsf_-_@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In the lead up to 2.6.13 I fixed a large number of reboot
> problems by making the calling conventions consistent.  Despite
> checking and double checking my work it appears I missed an
> obvious one.
> 
> The S4 suspend code for PM_DISK_PLATFORM was also calling
> device_shutdown without setting system_state, and was
> not calling the appropriate reboot_notifier.

ACK on both. But should not you submit patch via -mm, so it gets at
least some testing there?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
