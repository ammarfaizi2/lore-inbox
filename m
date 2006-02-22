Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWBVO0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWBVO0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWBVO0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:26:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2056 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751293AbWBVOZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:25:59 -0500
Date: Wed, 22 Feb 2006 14:25:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: uswsusp & initrd -- was Re: 2.6.16-rc4: known regressions
Message-ID: <20060222142511.GA2510@ucw.cz>
References: <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222112158.GB26268@thunk.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > To some degree, /initrd was supposed to do things like that, and in 
> > theory, it still could. However, realistically, 99% of any /initrd is more 
> > about the distribution than the kernel, so right now we have to count 
> > /initrd as a distribution thing, not a kernel thing.
> 
> ... and if we're truly going to be pouring more and more complexity
> into initrd (such as userspace swsusp), then (a) we probably should
> make it more of a kernel-specific thing, and not a distro-specific

Actually, distros started to do swsusp-resume-from-initrd long before
uswsusp -- because of scsi modules. So that complexity exists
already...

Anyway somehow simplifying/kernelizing initrd would be nice. Right now
I'm using read-only ext2 as poor-mans initrd (because it is easier to
set up that way).
							Pavel
-- 
Thanks, Sharp!
