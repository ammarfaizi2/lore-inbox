Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVLKStM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVLKStM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVLKStM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:49:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:34464 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750792AbVLKStM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:49:12 -0500
Date: Sun, 11 Dec 2005 10:33:50 -0800
From: Greg KH <greg@kroah.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, Tilman Schmidt <tilman@imap.cc>
Subject: Re: [linux-usb-devel] [PATCH 6/9] isdn4linux: Siemens Gigaset drivers - procfs interface
Message-ID: <20051211183350.GA10329@kroah.com>
References: <gigaset307x.2005.12.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.2@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.3@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.4@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.5@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.6@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2005.12.11.001.6@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 07:20:38PM +0100, Hansjoerg Lipp wrote:
> From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>
> 
> This patch adds the procfs interface to the gigaset module.

Are there existing userspace tools that rely on proc files for isdn
control?  If not, please do not add new proc files, these should be in
sysfs instead.

thanks,

greg k-h
