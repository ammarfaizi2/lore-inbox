Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVGLW4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVGLW4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVGLW4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:56:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51413 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261828AbVGLW4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:56:04 -0400
Date: Wed, 13 Jul 2005 00:48:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] suspend: update documentation
Message-ID: <20050712224827.GB2184@elf.ucw.cz>
References: <20050712090510.GG1854@elf.ucw.cz> <20050712102407.0fce8b7c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712102407.0fce8b7c.rdunlap@xenotime.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> | diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
> | --- a/Documentation/power/swsusp.txt
> | +++ b/Documentation/power/swsusp.txt
> | @@ -318,3 +318,10 @@ As a rule of thumb use encrypted swap to
> |  system is shut down or suspended. Additionally use the encrypted
> |  suspend image to prevent sensitive data from being stolen after
> |  resume.
> | +
> | +Q: Why we cannot suspend to a swap file?
> 
> Q: Why can't we suspend to a swap file?
> or
> Q: Why can we not suspend to a swap file?

Thanks, fixed.

> | +
> | +A: Because accessing swap file needs the filesystem mounted, and
> | +filesystem might do something wrong (like replaying the journal)
> | +during mount. [Probably could be solved by modifying every filesystem
> | +to support some kind of "really read-only!" option. Patches welcome.]
> | diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
> | --- a/Documentation/power/video.txt
> | +++ b/Documentation/power/video.txt
> | @@ -46,6 +46,12 @@ There are a few types of systems where v
> |    POSTing bios works. Ole Rohne has patch to do just that at
> |    http://dev.gentoo.org/~marineam/patch-radeonfb-2.6.11-rc2-mm2.
> |  
> | +(8) on some systems, you can use the video_post utility mentioned here:
> | +  http://bugzilla.kernel.org/show_bug.cgi?id=3670. Do echo 3 > /sys/power/state
> 
> That attachment is weird for me.  It downloads as "attachment.cgi", but
> it's a tar.gz file.  :(        (using firefox if it matters)

I think I actually got that file from server somehow, but it was not
exactly easy :-(.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
