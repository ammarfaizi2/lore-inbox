Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWBCKXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWBCKXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWBCKXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:23:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60904 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751178AbWBCKXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:23:46 -0500
Date: Fri, 3 Feb 2006 02:23:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: rlrevell@joe-job.com, pavel@ucw.cz, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-Id: <20060203022305.2e619476.akpm@osdl.org>
In-Reply-To: <E1F4xZN-0001K1-00@chiark.greenend.org.uk>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	<200602022131.59928.nigel@suspend2.net>
	<20060202115907.GH1884@elf.ucw.cz>
	<200602022214.52752.nigel@suspend2.net>
	<20060202152316.GC8944@ucw.cz>
	<20060202132708.62881af6.akpm@osdl.org>
	<1138916079.15691.130.camel@mindpipe>
	<20060202142323.088a585c.akpm@osdl.org>
	<20060202142323.088a585c.akpm@osdl.org>
	<1138919381.15691.162.camel@mindpipe>
	<E1F4xZN-0001K1-00@chiark.greenend.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
>
> (By and large, the biggest problem is repeated kernel regressions that
>  hit suspend in bizarre ways. This doesn't get picked up on quickly
>  because almost nobody is using this code, because "everyone knows" it
>  doesn't work. Except it /does/. What we need is for distributions to
>  actually work together on this, rather than everyone trying to fix the
>  same problems independently, each coming up with different solutions and
>  the world generally being a miserable place)

Is it still the case that swsusp requries that the disk drivers be
statically linked into vmlinux?

If so, I'd have thought that this was quite a problem for distros,
although I have a vague feeling that RH worked around it in some manner.
