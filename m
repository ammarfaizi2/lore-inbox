Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVCAMDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVCAMDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 07:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVCAMDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 07:03:13 -0500
Received: from gprs215-195.eurotel.cz ([160.218.215.195]:45788 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261885AbVCAMC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 07:02:59 -0500
Date: Tue, 1 Mar 2005 13:02:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       barryn@pobox.com, marado@student.dei.uc.pt,
       acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-ID: <20050301120246.GM1345@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301015231.091b5329.akpm@osdl.org> <20050301105448.GG1345@elf.ucw.cz> <m1psyjr559.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psyjr559.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, the patch is very ugly. If something like this needs to be done,
> > then perhaps acpi should properly register into driver model and do
> > the work there. This will also mean code will be called consistently.
> 
> I totally agree.  Do you have an example of how a non-device
> can do this?
> 
> In particular something that gets as close to shutting down
> the system devices as possible.  But gets called before that.
> 
> Or perhaps acpi should simply be setup to be the first system device?

I believe that's the prefered solution.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
