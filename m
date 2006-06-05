Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751098AbWFENQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWFENQE (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWFENQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:16:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12161 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750782AbWFENQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:16:01 -0400
Date: Mon, 5 Jun 2006 15:15:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] swsusp: allow drivers to determine between write-resume and actual wakeup
Message-ID: <20060605131516.GD2132@elf.ucw.cz>
References: <20060605091131.GE8106@htj.dyndns.org> <20060605092342.GI5540@elf.ucw.cz> <44841AA0.4060404@gmail.com> <448426FE.8090801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448426FE.8090801@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 05-06-06 21:43:42, Tejun Heo wrote:
> Tejun Heo wrote:
> >Pavel Machek wrote:
> >>If you want to know if you RESUME was after normal FREEZE or if it is
> >>after reboot, there's better patch floating around to do that.
> >
> >Yeap, this is what I'm interested in.  Care to give me a pointer?
> 
> And, one more things.  As written in the first mail, for libata, it 
> would be nice to know if a device suspend is due to runtime PM event 
> (per-device) or system wide suspend.  What do you think about this?  If 
> you agree, what method do you recommend to determine that?

Currently, runtime pm is unsupported/broken; so any request can be
thought as system pm.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
