Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbUK0DsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUK0DsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUK0DsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:48:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:9142 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262612AbUK0D2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 22:28:34 -0500
Date: Fri, 26 Nov 2004 19:28:17 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: USB DVD
Message-ID: <20041127032817.GD10536@kroah.com>
References: <20041125150313.GB9950@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125150313.GB9950@animx.eu.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 10:03:13AM -0500, Wakko Warner wrote:
> I have a USB DVD writer (I don't think the 'writer' part makes a difference)
> that when I attempt to view a DVD Movie, it can't read some of the sectors
> (DVD Auth I guess).  The same drive internally on ide works.  Is a problem
> with USB or the enclosure?

Odds are it's the enclosure :)

But to be sure, can you enable CONFIG_USB_STORAGE_DEBUG and send the
resulting log to the linux-usb-devel mailing list?

thanks,

greg k-h
