Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278392AbRJMUMW>; Sat, 13 Oct 2001 16:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278391AbRJMUMN>; Sat, 13 Oct 2001 16:12:13 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:46596 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S278392AbRJMUMD>;
	Sat, 13 Oct 2001 16:12:03 -0400
Date: Sat, 6 Oct 2001 00:35:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: specific optimizations for unaccelerated framebuffers
Message-ID: <20011006003547.A42@toy.ucw.cz>
In-Reply-To: <3BBC4A4E.AC6106A6@ftel.co.uk> <20011004123118.49603.qmail@web11806.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011004123118.49603.qmail@web11806.mail.yahoo.com>; from etienne_lorrain@yahoo.fr on Thu, Oct 04, 2001 at 02:31:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   I am not speaking of DMA'ing at the refresh frequency (approx 70 times
>  per second the complete video memory), just the modified 64Kb blocks,
>  "once upon a while": if a single pixel is written twice, you will just
>  see the latter written value on the screen - but who cares.
>   Been able to DMA the complete video memory image around 5-10 times/second
>  should be over the human eye sensitivity.
>   Moreover this pixel will stay on the processor memory cache a lot
>  longer, even without MTRR processors.

Yep, that should work. Same trick as xterm uses.
								Pavel
[Of course, user *will* see you are only updating at 5fps... But it will
be way beter than current slowness.] Are you going to create a patch?
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

