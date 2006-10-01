Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWJASQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWJASQN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWJASQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:16:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5265 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932161AbWJASQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:16:12 -0400
Message-ID: <452005E7.5030705@garzik.org>
Date: Sun, 01 Oct 2006 14:16:07 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Daniel Walker <dwalker@mvista.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Announce: gcc bogus warning repository
References: <451FC657.6090603@garzik.org>	<1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20061001111226.3e14133f.akpm@osdl.org>
In-Reply-To: <20061001111226.3e14133f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> The downsides are that it muckies up the source a little and introduces a
> very small risk that real use-uninitialised bugs will be hidden.  But I
> believe the benefit outweighs those disadvantages.

How about just marking the ones I've already done in #gccbug?

If I'm taking the time to audit the code, and separate out bogosities 
from real bugs, it would be nice not to see that effort wasted.

#gccbug includes _only_ the bogosities.  I didn't just blindly paper 
over everything with a 'may be used uninitialized' warning.  I'm well 
over halfway through the 'make allmodconfig' build, and as LKML emails 
can attest, have found several valid warnings.

	Jeff


