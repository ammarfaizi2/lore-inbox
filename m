Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbTIJQjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTIJQjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:39:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:18154 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265250AbTIJQjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:39:08 -0400
Date: Wed, 10 Sep 2003 09:39:19 -0700
From: Greg KH <greg@kroah.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] USB oops
Message-ID: <20030910163919.GA3061@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0309101720540.14731@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0309101720540.14731@dns.toxicfilms.tv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 05:23:59PM +0200, Maciej Soltysiak wrote:
> Hi,
> 
> I got this calltrace after doing these steps:
> 1) remove an mp3 player from usb without unmount it
> 2) come back the day after and plug it in
> 3) try to unmount the device after noticing it has not been unmounted
> 
> unmount segfaults

What kernel version are you using?

This looks like a scsi error that has been recently fixed.

greg k-h
