Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWJAS0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWJAS0d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWJAS0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:26:33 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:25391 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932142AbWJAS0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:26:30 -0400
Subject: Re: Announce: gcc bogus warning repository
From: Daniel Walker <dwalker@mvista.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <452005E7.5030705@garzik.org>
References: <451FC657.6090603@garzik.org>
	 <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061001111226.3e14133f.akpm@osdl.org>  <452005E7.5030705@garzik.org>
Content-Type: text/plain
Date: Sun, 01 Oct 2006 11:26:28 -0700
Message-Id: <1159727188.24767.9.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 14:16 -0400, Jeff Garzik wrote:
> Andrew Morton wrote:
> > The downsides are that it muckies up the source a little and introduces a
> > very small risk that real use-uninitialised bugs will be hidden.  But I
> > believe the benefit outweighs those disadvantages.
> 
> How about just marking the ones I've already done in #gccbug?
> 
> If I'm taking the time to audit the code, and separate out bogosities 
> from real bugs, it would be nice not to see that effort wasted.

There was a long thread on this, it's not about anyone not reviewing the
code properly when the warning is first silenced. It's that future
changes might create new problems that are also silenced. I don't think
it's a huge concern, especially since there's was a config option to
turn the warning backs on.

Daniel

