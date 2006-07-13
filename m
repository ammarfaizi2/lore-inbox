Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWGMO3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWGMO3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWGMO3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:29:09 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:18446 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751542AbWGMO3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:29:08 -0400
Date: Thu, 13 Jul 2006 10:29:05 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: Dave Jones <davej@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: annoying frequent overcurrent messages.
In-Reply-To: <20060713120815.GA5727@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0607131027200.6702-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, Pavel Machek wrote:

> > Well, overcurrent is a potentially dangerous situation.  That's why it 
> > gets reported with dev_err priority.
> 
> Well, I see overcurrents all the time while doing suspend/resume...
> 
> Why is it dangerous? USB should survive plugging something that
> connects +5V and ground. It may turn your machine off, but that should
> be it...?

The key words here are "potentially", "should", and "may".

BTW, what sort of overcurrents do you see during suspend/resume?

Alan Stern

