Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUCZAIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbUCZAH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:07:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:32431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263832AbUCYX6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:12 -0500
Date: Thu, 25 Mar 2004 15:57:40 -0800
From: Greg KH <greg@kroah.com>
To: James Lamanna <jamesl@appliedminds.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Figuring out USB device locations
Message-ID: <20040325235740.GA30964@kroah.com>
References: <406314EF.7040304@appliedminds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406314EF.7040304@appliedminds.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 09:20:47AM -0800, James Lamanna wrote:
> Is there an easy way to find out what /dev entries usb devices get 
> mapped to from userspace?

"easy way" on 2.4?  No, sorry.  You need 2.6 to determine this in a
simple manner.  But there are some files in the /proc/bus/usb/
and /proc/bus/input/ directories that will help you out.

Good luck,

greg k-h
