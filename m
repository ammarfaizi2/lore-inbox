Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVBVXXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVBVXXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVBVXXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:23:30 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:10557 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261354AbVBVXWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:22:01 -0500
Date: Tue, 22 Feb 2005 15:21:42 -0800
From: Greg KH <gregkh@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Malcolm Rowe <malcolm-linux@farside.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlink /sys/class/block to /sys/block
Message-ID: <20050222232142.GA10372@suse.de>
References: <courier.4217CBC9.000027C1@mail.farside.org.uk> <20050222230634.GB16383@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222230634.GB16383@taniwha.stupidest.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 03:06:34PM -0800, Chris Wedgwood wrote:
> On Sat, Feb 19, 2005 at 11:29:13PM +0000, Malcolm Rowe wrote:
> 
> > Following the discussion in [1], the attached patch creates
> > /sys/class/block as a symlink to /sys/block. The patch applies to
> > 2.6.11-rc4-bk7.
> 
> Shouldn't we really move /sys/block to /sys/class/block and put the
> symlink from there to /sys/block with the hope of removing it one day?

When struct class_device can support children, we can do just that.  But
that support has not been added, yet...

thanks,

greg k-h
