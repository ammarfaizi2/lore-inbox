Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVALT7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVALT7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVALT7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:59:24 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:61861 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261347AbVALTrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:47:03 -0500
Date: Wed, 12 Jan 2005 14:45:07 -0500 (EST)
From: Gregory Boyce <gboyce@badbelly.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel releases for security updates
Message-ID: <Pine.LNX.4.61.0501121340560.20156@buddha.badbelly.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Lately on this list I have been hearing a lot of discussion about putting 
out point releases for security and bug fixes to the stable series of 
kernels.  There has even been a single release (2.6.8.1) that actually 
followed through with this.

What has not been clear to me from the threads is how far back people are 
planning on supporting with these point releases?  A lot of people seem to 
be very interested in being able to run a kernel for extended lengths of 
time, but most of the discussion on point releases has been about getting 
a 2.6.X.1 while 2.6.X+1 is still in it's pre stages.  What about the 
people running 2.6.X-1?  Can they expect to get a point release for 
security updates?

I've been thinking about this, and it seems to me that there is going to 
have to be a choice between either supporting just the current stable 
release, or supporting the last X releases.  The first option is going to 
leave a lot of people unhappy as major changes get put into releases, and 
the other option is going to be painful to support.

Rather than actually putting out point releases for the previously 
released kernels, why not just create a centralized repository for the 
security patches?  In a lot of cases security patches can be applied as is 
to a number of different kernel revisions.  For the ones that cannot, 
variances of the patches could be posted along with it clearly marked as 
to which patches apply to which kernels.

Thoughts?

--
Greg Boyce
