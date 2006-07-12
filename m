Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWGLSHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWGLSHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWGLSHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:07:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:52497 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932295AbWGLSH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:07:29 -0400
Date: Wed, 12 Jul 2006 14:07:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Dave Jones <davej@redhat.com>
cc: ray-gmail@madrabbit.org,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: annoying frequent overcurrent messages.
In-Reply-To: <20060712175124.GF14453@redhat.com>
Message-ID: <Pine.LNX.4.44L0.0607121405080.6111-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006, Dave Jones wrote:

> On Wed, Jul 12, 2006 at 01:19:43PM -0400, Alan Stern wrote:
>  > On Wed, 12 Jul 2006, Dave Jones wrote:
>  > 
>  > > we could at least rate-limit the messages.
>  > 
>  > That's true for every message in the kernel.  How do you decide which 
>  > messages to rate-limit?
> 
> anything the user doesn't have any means of fixing should be able to be
> ignored. With dmesg filled with these, it's hard to ignore them.

That wasn't a rhetorical question.  A large percentage of the messages in
the USB hub driver have the potential to spam the syslog, given the right
sort of hardware disfunction.  But it doesn't seem practical to rate-limit
all of them.

Alan Stern

