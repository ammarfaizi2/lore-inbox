Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbULQQOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbULQQOH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbULQQN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:13:56 -0500
Received: from ida.rowland.org ([192.131.102.52]:9476 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261815AbULQQMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:12:37 -0500
Date: Fri, 17 Dec 2004 11:12:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Pavel Machek <pavel@ucw.cz>, <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: Cleanup PCI power states
In-Reply-To: <20041217000526.GA11531@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0412171109260.1920-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Greg KH wrote:

> Hm, ok, can everyone agree (especially the linux-pm list people) that
> the patch below is the way we are all moving toward?

Yes, provided it is clear that this code only gives a _default_ mapping 
and that drivers will have access to the complete pm_message_t data so 
they can choose a different mapping if they want.

Alan Stern

