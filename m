Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUAWSKN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266614AbUAWSKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:10:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27568 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265263AbUAWSKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:10:11 -0500
Date: Fri, 23 Jan 2004 18:10:04 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040123181004.GJ21151@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0401230939170.2151@home.osdl.org> <Pine.LNX.4.44L0.0401231248510.856-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0401231248510.856-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 01:03:33PM -0500, Alan Stern wrote:
> The general context is that a module is trying to unload, but it can't
> until the release() callback for its device has finished.

... and if I redirect rmmod stdin from sysfs, we get what?  Exactly.
