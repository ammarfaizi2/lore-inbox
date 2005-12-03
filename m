Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVLCXC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVLCXC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVLCXC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:02:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:60616 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751294AbVLCXC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:02:57 -0500
X-Authenticated: #428038
Date: Sun, 4 Dec 2005 00:02:54 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@redhat.com>, Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203230254.GI25722@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Dave Jones <davej@redhat.com>, Lars Marowsky-Bree <lmb@suse.de>
References: <20051203135608.GJ31395@stusta.de> <20051203205911.GX18919@marowsky-bree.de> <20051203211329.GC25015@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203211329.GC25015@redhat.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Dec 2005, Dave Jones wrote:

> In many cases, submitters of changes know that things are going
> to break. Maybe we need a policy that says changes requiring userspace updates
> need to be clearly documented in the mails Linus gets (Especially if its
> a git pull request), so that when the next point release gets released,
> Linus can put a section in the announcement detailing what bits
> of userspace are needed to be updated.

This isn't acceptable in stable kernels. FreeBSD has a very tight
policy, newer kernels off the same branch support older user space. The
upgrade path is clear, reboot into new kernel, have it spit a few
reminders that your userspace needs update (Linux also has this, for
instance, with SG_IO and its predecessors) but still everything works.

Requiring new userspace at a patchlevel kernel upgrade is nothing but
impertinent, unless that updated userspace ships as part of the kernel.

> It still isn't to solve the problem of regressions in drivers, but
> that's a problem that's not easily solvable.

-- 
Matthias Andree
