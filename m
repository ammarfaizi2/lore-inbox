Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbVCQInn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVCQInn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 03:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVCQInn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 03:43:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:61146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263018AbVCQInk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 03:43:40 -0500
Date: Wed, 16 Mar 2005 23:09:40 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [PATCH] Add a non-blocking interface to the I2C code, part 1
Message-ID: <20050317070940.GA15508@kroah.com>
References: <42261AFB.40001@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42261AFB.40001@acm.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 01:58:51PM -0600, Corey Minyard wrote:
> This patch reorganizes the I2C SMBus formatting code to make it more
> suitable for the upcoming non-blocking changes.

You are changing too much stuff here to claim it's just a
reorganization:
	- variable name changes for no reason
	- coding style changes (improper ones at that)
	- logic changes.

What exactly are you doing with this patch, and why?

thanks,

greg k-h
