Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265363AbUBESzT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUBESzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:55:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:24192 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265363AbUBESzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:55:15 -0500
Date: Thu, 5 Feb 2004 10:55:04 -0800
From: Greg KH <greg@kroah.com>
To: "King, Steven R" <steven.r.king@intel.com>, linux-kernel@vger.kernel.org
Cc: infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Message-ID: <20040205185504.GD13434@kroah.com>
References: <33561BB7A415E04FBDC339D5E149C6E26C38FA@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33561BB7A415E04FBDC339D5E149C6E26C38FA@orsmsx405.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 10:27:54AM -0800, King, Steven R wrote:
> Hi Greg,
> What exactly is wrong with spinlock?  Far as I know, it's been working
> bug-free on a variety of platforms for quite some time now.  The other
> abstractions such as atomic_t are for platform portability.

Again, compare them to the current kernel spinlocks and try to realize
why your implementation of spinlock_irqsave() will not work on all
platforms.

Come on, just use the kernel versions, there is no need to reinvent the
wheel all of the time, it just wastes everyones time (including mine...)

thanks,

greg k-h
