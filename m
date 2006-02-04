Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946140AbWBDAhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946140AbWBDAhC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946142AbWBDAhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:37:00 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:44809 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1946141AbWBDAhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:37:00 -0500
Date: Sat, 4 Feb 2006 01:36:59 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060204003659.GC4845@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
	linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <200602030918.07006.nigel@suspend2.net> <20060203120055.0nu3ym4yuck0os84@imp.rexursive.com> <20060202171812.49b86721.akpm@osdl.org> <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com> <20060203114948.GC2972@elf.ucw.cz> <1139010204.2191.14.camel@coyote.rexursive.com> <20060203235546.GB3291@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203235546.GB3291@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 12:55:47AM +0100, Pavel Machek wrote:
> The weird reasons were stated few times already. My favourite weird
> reason is "can be done in userspace" these days.

Oh please, stop that.  Network can be done in userspace.  NFS can be
done in userspace.  Filesystems can be done in userspace.  You need a
better reason than that.

Now the pressure to add progress bar and other chrome, I can
understand.  Not wanting the chrome in the kernel, I understand even
more.  Deciding the solution for that is to more everything in
userspace and end up with the quality and stability of the suspend
fonctionality hostage to the quality of chrome code, I don't
understand that one.  Have you seen the state of multimedia playing
applications lately, where chrome won over functionality?  It's
dreadful, even if flashy.

Why don't you try to design the system so that the progress bar can't
fuck up the suspend unless they really, really want to?  Instead of
one where a forgotten open(O_CREAT) in a corner of graphics code can
randomly trash the filesystem through metadata corruption?

  OG.

