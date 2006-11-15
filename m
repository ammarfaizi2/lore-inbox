Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030971AbWKOUYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030971AbWKOUYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030970AbWKOUYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:24:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62166 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030971AbWKOUYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:24:34 -0500
Date: Wed, 15 Nov 2006 21:24:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mikael Pettersson <mikpe@it.uu.se>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061115202418.GC3875@elf.ucw.cz>
References: <200611122047.kACKl8KP004895@harpo.it.uu.se> <20061112212941.GA31624@flint.arm.linux.org.uk> <20061112220318.GA3387@elte.hu> <20061112235410.GB31624@flint.arm.linux.org.uk> <20061114110958.GB2242@elf.ucw.cz> <1163522062.14674.3.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163522062.14674.3.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-11-14 11:34:21, Lee Revell wrote:
> On Tue, 2006-11-14 at 12:09 +0100, Pavel Machek wrote:
> > Suspending with mounted floppy is a user error.
> 
> Huh?  How so?

Floppy is removable, and you are expected to umount removable devices
before suspend.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
