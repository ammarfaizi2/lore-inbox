Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVFNV2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVFNV2B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVFNV2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:28:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:27046 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261345AbVFNV17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:27:59 -0400
Date: Tue, 14 Jun 2005 14:27:47 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: off by one in sysfs
Message-ID: <20050614212747.GA20136@kroah.com>
References: <9e47339105061120007061d7b1@mail.gmail.com> <20050614210729.GC19875@kroah.com> <9e4733910506141421382961d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910506141421382961d2@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 05:21:54PM -0400, Jon Smirl wrote:
> On 6/14/05, Greg KH <greg@kroah.com> wrote:
> > On Sat, Jun 11, 2005 at 11:00:00PM -0400, Jon Smirl wrote:
> > > My attribute is a color_map described by 255 lines of 15 chars plus \n.
> > 
> > Heh, that's pretty big for a single attribute.  Would it be easier to
> > just use the binary sysfs file interface for this attribute?
> 
> The attribute is formatted in ascii. You can use a script to set it if
> you want. It is the gamma correction table for the monitor.

Ok, just curious, no big deal.

greg k-h
