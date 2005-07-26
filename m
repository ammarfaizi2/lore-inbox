Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVGZVC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVGZVC6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVGZVC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:02:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7656 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262081AbVGZVCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:02:11 -0400
Date: Tue, 26 Jul 2005 23:02:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/23] swpsuspend:  Have suspend to disk use factors of sys_reboot
Message-ID: <20050726210203.GB23224@elf.ucw.cz>
References: <m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com> <m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com> <m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com> <m1br4pcva4.fsf_-_@ebiederm.dsl.xmission.com> <m17jfdcv79.fsf_-_@ebiederm.dsl.xmission.com> <m13bq1cv3k.fsf_-_@ebiederm.dsl.xmission.com> <m1y87tbgeo.fsf_-_@ebiederm.dsl.xmission.com> <m1u0ihbg85.fsf_-_@ebiederm.dsl.xmission.com> <m1pst5bg5u.fsf_-_@ebiederm.dsl.xmission.com> <20050726135749.14bf26df.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726135749.14bf26df.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The suspend to disk code was a poor copy of the code in
> > sys_reboot now that we have kernel_power_off, kernel_restart
> > and kernel_halt use them instead of poorly duplicating them inline.
> > 
> > Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
..
> This one conflicts in both implementation and intent with the below, from Pavel.  I'll
> drop Pavel's patch.
> 
> 
> From: Pavel Machek <pavel@ucw.cz>
> 
> Do not call device_shutdown with interrupts disabled.  It is wrong and
> produces ugly warnings.

Okay with me.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
