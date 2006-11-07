Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753377AbWKGHD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbWKGHD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 02:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbWKGHD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 02:03:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30686 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1753377AbWKGHD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 02:03:56 -0500
Date: Tue, 7 Nov 2006 08:03:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Burman Yan <yan_952@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt handling
Message-ID: <20061107070347.GA21655@elf.ucw.cz>
References: <BAY20-F36829F468180F55694798D8FE0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY20-F36829F468180F55694798D8FE0@phx.gbl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The driver supports:
> 1) interface similar to hdaps that allows running hdapsd with trivial 
> modifiations
> 2) input class device that allows playing games such as neverball by using 
> the laptop as a joystick
...
> 4) A misc device /dev/acel similar in interface to /dev/rtc that reacts on 
> interrupts from the accelerometer allowing userspace to catch such events 
> and react accordingly - park the HD heads, or perhaps print "Your laptop is 
> falling. Are you sure you want to catch it?" The daemon for that
> i trivial.

Ahh, so 2 different interfaces (/sys + input) for hdaps was not
enough, now we have 3rd one :-(. Can't we somehow improve one of them
(input?) so that we can remove  the remaining two?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
