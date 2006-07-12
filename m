Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWGLRve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWGLRve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWGLRvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:51:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52715 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932153AbWGLRvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:51:33 -0400
Date: Wed, 12 Jul 2006 13:51:24 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ray-gmail@madrabbit.org,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: annoying frequent overcurrent messages.
Message-ID: <20060712175124.GF14453@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>, ray-gmail@madrabbit.org,
	Kernel development list <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>
References: <2c0942db0607121009l1fc00764ye0b98d686700a74c@mail.gmail.com> <Pine.LNX.4.44L0.0607121314490.6111-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0607121314490.6111-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 01:19:43PM -0400, Alan Stern wrote:
 > On Wed, 12 Jul 2006, Dave Jones wrote:
 > 
 > > we could at least rate-limit the messages.
 > 
 > That's true for every message in the kernel.  How do you decide which 
 > messages to rate-limit?

anything the user doesn't have any means of fixing should be able to be
ignored. With dmesg filled with these, it's hard to ignore them.

 > Note that this particular message will cause problems only in the presence 
 > of defective hardware.

Defective it may be, I'm not arguing that.    But spewing hundreds of
these an hour isn't going to make the user fix the problem (if they even can)
any faster.

*grumbles and goes to edit modprobe.conf*

		Dave

-- 
http://www.codemonkey.org.uk
