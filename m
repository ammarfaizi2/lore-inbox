Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWDZFWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWDZFWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWDZFWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:22:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:12982 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932374AbWDZFWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:22:40 -0400
Date: Tue, 25 Apr 2006 22:17:33 -0700
From: Greg KH <greg@kroah.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Jens Axboe <axboe@suse.de>
Subject: Re: [patch 1/3] use kref for blk_queue_tag
Message-ID: <20060426051733.GA332@kroah.com>
References: <20060426021059.235216000@localhost.localdomain> <20060426021121.260553000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426021121.260553000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 10:11:00AM +0800, Akinobu Mita wrote:
> Use kref for reference counter of blk_queue_tag.

Why?

Doesn't this, and your other patches here affect performance?

thanks,

greg k-h
