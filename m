Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVCYTW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVCYTW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVCYTW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:22:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:44263 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261751AbVCYTWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:22:13 -0500
Date: Fri, 25 Mar 2005 11:20:24 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [0/12] More Driver Model Locking Changes
Message-ID: <20050325192024.GA14290@kroah.com>
References: <Pine.LNX.4.50.0503242145200.29800-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0503242145200.29800-100000@monsoon.he.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 09:54:24PM -0800, Patrick Mochel wrote:
> 
> Here is the next round of driver model locking changes. These build off of
> the previous set of changes, including the klist patch. They eradicate all
> of the uses of the subsystems' rwsem in the driver core.
> 
> It does include the fix posted earlier that happened when removing the
> driver.
> 
> A summary is listed below. The patches follow.

Looks great, I've pulled all of these into my tree.

thanks a lot for doing this work.

greg k-h
