Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269681AbUISAyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269681AbUISAyu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 20:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUISAyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 20:54:50 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:25789 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269681AbUISAys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 20:54:48 -0400
Message-ID: <9e47339104091817545b3d2675@mail.gmail.com>
Date: Sat, 18 Sep 2004 20:54:46 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Keith Packard <keithp@keithp.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
Cc: Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E1C8oiI-0001xU-UG@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091815125ef78738@mail.gmail.com>
	 <E1C8oiI-0001xU-UG@evo.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't there an enviroment variable that tells what device is the
console for the session? How do you tell what serial port you're on
when multiple people are logged in on serial lines?


On Sat, 18 Sep 2004 16:33:54 -0700, Keith Packard <keithp@keithp.com> wrote:
> 
> Around 18 o'clock on Sep 18, Jon Smirl wrote:
> 
> > The sysfs scheme has the advantage that there is no special user
> > command required. You just use echo or cp to set the mode.
> 
> But it makes it difficult to associate the sysfs entry with the particular
> session.  Seems like permitting multiple opens of /dev/fb0 with mode
> setting done on that file pointer will be easier to keep straight
> 
> 
> 
> 



-- 
Jon Smirl
jonsmirl@gmail.com
