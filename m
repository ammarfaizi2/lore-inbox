Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUBGAGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbUBGAGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:06:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55277 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265682AbUBGAGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:06:10 -0500
Date: Sat, 7 Feb 2004 00:06:10 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] Kernel panic with ppa driver updates
Message-ID: <20040207000610.GQ21151@parcelfarce.linux.theplanet.co.uk>
References: <4023D098.1000904@myrealbox.com> <20040206182844.GJ21151@parcelfarce.linux.theplanet.co.uk> <4023FCE5.1020300@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4023FCE5.1020300@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 12:45:25PM -0800, walt wrote:
> >Could you post the actual oops? ...
> 
> The reason I didn't post it is that it has already scrolled off the top of
> my console by the time I can read anything :-(   I can see the hex values
> for the registers and hex values for the stack trace, but nothing earlier
> than that.  I looked in /var/log/messages but I see that kjournald doesn't
> start until well after the oops.
> 
> I thought about compiling in support for console on serial-or-parallel
> port but I've never been clear on just what to plug into the serial-or-
> parallel port after I've done that.  Can you give me a hint how I can
> get the whole oops message for you?

Umm...  I wouldn't mess with parallel in this case.  Serial is simple -
you stick a nullmodem in it and in serial port on another box, then
run e.g. minicom on the other end.
