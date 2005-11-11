Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVKKKhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVKKKhA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVKKKhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:37:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60314 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932282AbVKKKg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:36:59 -0500
Date: Fri, 11 Nov 2005 11:36:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
Message-ID: <20051111103605.GC27805@elf.ucw.cz>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So some 486 processors do have CR4 register.  Allow them to present it in
> register dumps by using the old fault technique rather than testing processor
> family.

I thought Andi commented this as "way too risky", for little
good. Nested exceptions are evil.
									Pavel
-- 
Thanks, Sharp!
