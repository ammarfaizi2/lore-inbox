Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVGLDMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVGLDMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVGLDMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:12:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:31913 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261984AbVGLDKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:10:07 -0400
Date: Mon, 11 Jul 2005 20:09:58 -0700
From: Greg KH <greg@kroah.com>
To: Joe Sevy <jmsevy@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb mass storage bug
Message-ID: <20050712030958.GC1487@kroah.com>
References: <20050711203047.39437.qmail@web33113.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711203047.39437.qmail@web33113.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 01:30:47PM -0700, Joe Sevy wrote:
> Sorry, no logs or dmesg to report; just performance.
> Using kernel 2.6.12: USB flash drive (san-disk cruzer
> micro) Copy FROM drive is normal and quick; copy TO
> drive is amazingly slow. (30 minutes for 50K file).
> Used same configuration as for 2.6.11.11. Cured by
> going back to old kernel.

Are you using CONFIG_UB or CONFIG_USB_STORAGE?

Also, linux-usb-devel is the better place for this if you have a more
detailed report.

thanks,

greg k-h
