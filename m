Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVLFPJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVLFPJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbVLFPJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:09:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1943 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751670AbVLFPJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:09:42 -0500
Date: Tue, 6 Dec 2005 16:09:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jiri Benc <jbenc@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Joseph Jezak <josejx@gentoo.org>,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051206150909.GB1999@elf.ucw.cz>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org> <20051205195543.5a2e2a8d@griffin.suse.cz> <20051205191008.GA28433@infradead.org> <20051205203121.48241a08@griffin.suse.cz> <20051205194146.GA29317@infradead.org> <20051205211107.61941ab9@griffin.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205211107.61941ab9@griffin.suse.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That's because you still don't get how we do development.  The last thing
> > we want is full-scale rewrites.  Submit patches to fix things based on
> > whatever you want but do it incremental.
> 
> We have got almost finished and working stack. Everything we need to do
> is:
> 1. identify issues;
> 2. fix the issues; some of them will need broader discussion;
> 3. split it into several (potentially a lot of) reviewable patches;
> 4. clean up the drivers.
> 
> I'm in phase 2 now (no interesting results yet). I don't think it is

No, it does not work like that. You don't get nice, reviewable,
mergeable patches by developing code independently for 3 years or so
then attempting merge.

If devicescape code is better than mainline, merge it _now_. If it is
not, drop it and start from mainline code.

> And if you are familiar with the current in-kernel 802.11 code (and if
> you know at least two different drivers), you will probably agree that
> many things have to be changed in the current code even if we decided to
> build on the top of it, so the result will finally differ a lot and will
> be almost incompatible with the current code.

That's okay; as long as incremental way exist, first version not being
compatible with last version is not a problem.
								Pavel

-- 
Thanks, Sharp!
