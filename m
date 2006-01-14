Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423250AbWANBVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423250AbWANBVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423253AbWANBVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:21:35 -0500
Received: from hermes.domdv.de ([193.102.202.1]:12304 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1423250AbWANBVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:21:34 -0500
Message-ID: <43C85213.40808@domdv.de>
Date: Sat, 14 Jan 2006 02:21:23 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Sven-Thorsten Dietrich <sven@mvista.com>, thockin@hockin.org,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
References: <1137178855.15108.42.camel@mindpipe><Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz><20060113215609.GA30634@hockin.org><Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz> <1137190698.2536.65.camel@localhost.localdomain> <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz> <43C848C7.1070701@domdv.de> <Pine.LNX.4.62.0601131701590.9821@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0601131701590.9821@qynat.qvtvafvgr.pbz>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
[snip]
> I'm not saying it's the right answer, but it's one of two workarounds
> currently available.
> 
> idle=poll causes increased power useage
> 
> timer source change (mentioned earlier in this thread) limits timer
> precision
> 
> neither of these are fixes, but by understanding the different costs
> people can choose the work around they want to use while waiting for a
> better fix.

The problem being that some of us use their laptops for audio work too.
And then high battery usage, noisy fans or lack of high res timers will
be really bad.

Simple example:
I do final mastering work using my laptop and Ardour/Jack/JAMin out of
house in a place with a good stage audio system (Mackie mixer, 2KW
Dynacord Amp/Syrincs S3) and a sufficient listening space to get a
proper bass mix. I run on battery in this case to avoid any kind of
audio interference (ground loops, etc). Now thinking of a dual core
laptop...
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
