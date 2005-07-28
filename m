Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVG1Hq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVG1Hq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVG1Hoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:44:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20647 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261334AbVG1Hmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:42:53 -0400
Date: Thu, 28 Jul 2005 09:42:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
Message-ID: <20050728074244.GG6529@elf.ucw.cz>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com> <20050727025923.7baa38c9.akpm@osdl.org> <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com> <20050727104123.7938477a.akpm@osdl.org> <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com> <20050727224711.GA6671@elf.ucw.cz> <m1y87r7sqf.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y87r7sqf.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So unless you are really ambitious I'd like to take
> device_suspend(PMSG_FREEZE) out of the reboot path for
> 2.6.13, put in -mm where people can bang on it for a bit
> and see that it is coming and delay the merge with the stable
> branch until the bugs with common hardware have been sorted out.

Works for me. I may feel ambitious, but I don't feel like debugging
every reboot problem or every strange architecture for 2.6.13 :-).

							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
