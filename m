Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263605AbRFKJT1>; Mon, 11 Jun 2001 05:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263554AbRFKJTR>; Mon, 11 Jun 2001 05:19:17 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:8708 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263605AbRFKJTH>;
	Mon, 11 Jun 2001 05:19:07 -0400
Date: Fri, 8 Jun 2001 19:38:06 +0000
From: Pavel Machek <pavel@suse.cz>
To: LA Walsh <law@sgi.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010608193805.B36@toy.ucw.cz>
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com> <3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com> <m1wv6p5uqp.fsf@frodo.biederman.org> <3B1EA748.6B9C1194@sgi.com> <m1g0dc6blz.fsf@frodo.biederman.org> <3B1F9CEC.928C8E66@sgi.com> <m1ofs044xc.fsf@frodo.biederman.org> <3B1FE85D.F7BE88F4@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B1FE85D.F7BE88F4@sgi.com>; from law@sgi.com on Thu, Jun 07, 2001 at 01:47:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     But if the page in memory is 'dirty', you can't be efficient with swapping
> *in* the page.  The page on disk is invalid and should be released, or am I
> missing something?

Yes. You are missing fragmentation. This keeps it low.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

