Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131347AbRDPME6>; Mon, 16 Apr 2001 08:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRDPMEs>; Mon, 16 Apr 2001 08:04:48 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:48389 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S131324AbRDPMDC>;
	Mon, 16 Apr 2001 08:03:02 -0400
Date: Thu, 12 Apr 2001 23:51:45 +0000
From: Pavel Machek <pavel@suse.cz>
To: george anzinger <george@mvista.com>
Cc: Rik van Riel <riel@conectiva.com.br>, SodaPop <soda@xirr.com>,
        alexey@datafoundation.com, linux-kernel@vger.kernel.org
Subject: Re: [test-PATCH] Re: [QUESTION] 2.4.x nice level
Message-ID: <20010412235144.A43@(none)>
In-Reply-To: <Pine.LNX.4.21.0104110726210.25737-100000@imladris.rielhome.conectiva> <3AD485E4.40BCBC0D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3AD485E4.40BCBC0D@mvista.com>; from george@mvista.com on Wed, Apr 11, 2001 at 09:27:16AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> One rule of optimization is to move any code you can outside the loop. 
> Why isn't the nice_to_ticks calculation done when nice is changed
> instead of EVERY recalc.?  I guess another way to ask this is, who needs

This way change is localized very nicely, and it is "obviously right".

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

