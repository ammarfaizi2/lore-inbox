Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWBCPxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWBCPxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 10:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWBCPxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 10:53:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6859 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750842AbWBCPxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 10:53:51 -0500
Date: Fri, 3 Feb 2006 10:53:23 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>, rlrevell@joe-job.com,
       pavel@ucw.cz, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203155323.GB24201@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
	rlrevell@joe-job.com, pavel@ucw.cz, nigel@suspend2.net,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe> <20060202142323.088a585c.akpm@osdl.org> <20060202142323.088a585c.akpm@osdl.org> <1138919381.15691.162.camel@mindpipe> <E1F4xZN-0001K1-00@chiark.greenend.org.uk> <20060203022305.2e619476.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203022305.2e619476.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 02:23:05AM -0800, Andrew Morton wrote:
 > Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
 > >
 > > (By and large, the biggest problem is repeated kernel regressions that
 > >  hit suspend in bizarre ways. This doesn't get picked up on quickly
 > >  because almost nobody is using this code, because "everyone knows" it
 > >  doesn't work. Except it /does/. What we need is for distributions to
 > >  actually work together on this, rather than everyone trying to fix the
 > >  same problems independently, each coming up with different solutions and
 > >  the world generally being a miserable place)
 > 
 > Is it still the case that swsusp requries that the disk drivers be
 > statically linked into vmlinux?
 > 
 > If so, I'd have thought that this was quite a problem for distros,
 > although I have a vague feeling that RH worked around it in some manner.

We do it all in the initrd, before any filesystems are touched.

		Dave

