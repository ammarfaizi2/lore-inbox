Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWA3Ezb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWA3Ezb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 23:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWA3Ezb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 23:55:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:5534 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751234AbWA3Eza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 23:55:30 -0500
Date: Sun, 29 Jan 2006 20:44:36 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 kernel init oops
Message-ID: <20060130044436.GA13244@kroah.com>
References: <20060128171841.6f989958.rdunlap@xenotime.net> <20060128175511.35e39233.rdunlap@xenotime.net> <20060129190029.GB7168@kroah.com> <20060129111934.53710b03.rdunlap@xenotime.net> <20060129201923.GB6972@kroah.com> <20060129130812.011d8bf3.rdunlap@xenotime.net> <20060129150737.6f911430.rdunlap@xenotime.net> <20060129165732.03446fc3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129165732.03446fc3.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 04:57:32PM -0800, Randy.Dunlap wrote:
> furthermore, this happens on 2.6.16-rc1 and 2.6.16-rc1-git4,
> but <platform_notify> is not at the same memory address in
> my builds, so it smells more like a bad ptr reference
> somewhere than like bad memory IMO.

Hm, can you do a git bisect from 2.6.15 to 2.6.16-rc1 to see if you can
find this?

thanks,

greg k-h
