Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbULSQxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbULSQxU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 11:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbULSQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 11:53:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:22752 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261312AbULSQxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 11:53:18 -0500
Date: Sun, 19 Dec 2004 08:52:41 -0800
From: Greg KH <greg@kroah.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usbdevfs mount failure with 2.6.10-rc3
Message-ID: <20041219165240.GA7610@kroah.com>
References: <04I4WDU12@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04I4WDU12@server5.heliogroup.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 01:34:42PM +0000, Hubert Tonneau wrote:
> With 2.6.10-rc3 I get ENODEV error when trying to mount usbdevfs
> No problem with 2.6.9

The name "usbdevfs" has been obsolete for a number of years now.  Please
just use "usbfs" instead.  That also works just fine for 2.4, so it is
backwards compatible.

thanks,

greg k-h
