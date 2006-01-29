Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWA2PZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWA2PZE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 10:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWA2PZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 10:25:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36796 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751029AbWA2PZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 10:25:02 -0500
Date: Sun, 29 Jan 2006 16:24:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Only allow a threaded init to exec from the thread_group_leader
Message-ID: <20060129152451.GD1764@elf.ucw.cz>
References: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com> <20060129003606.7887ecd9.akpm@osdl.org> <m1irs38h5v.fsf@ebiederm.dsl.xmission.com> <20060129024831.4474142f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129024831.4474142f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 29-01-06 02:48:31, Andrew Morton wrote:
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> >  If process id namespaces become a reality init stops being
> >  terribly special, and becomes something you may have several
> >  of running at any one time.  If one of those inits is compromised
> >  by a hostile user I having the whole system go down so we can
> >  avoid executing a cheap test sounds terribly wrong.  That is
> >  why I really care.
> 
> Wouldn't it be better to do nothing until/unless there's some code in the
> kernel or init which actually needs the change?

It is common to do init=/bin/bash, and I guess people are doing it
with all kinds of wonderful apps....
								Pavel
-- 
Thanks, Sharp!
