Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVBYXCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVBYXCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVBYXCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:02:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:53725 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262789AbVBYXCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:02:06 -0500
Date: Fri, 25 Feb 2005 14:36:49 -0800
From: Greg KH <greg@kroah.com>
To: Sumit Narayan <talk2sumit@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB IDE Connector
Message-ID: <20050225223649.GA28014@kroah.com>
References: <1458d96105022421001e006f5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458d96105022421001e006f5f@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 10:30:27AM +0530, Sumit Narayan wrote:
> Hi,
> 
> I have an external IDE connector through USB port. Where could I get
> the exact point inside the kernel, from where I would get information
> such as Block No., Request size, partition details for a particular
> request, _just_ before being sent to the disk.
> 
> Like, for a normal IDE, I could gather these details from inside the
> function __ide_do_rw_disk from "struct request". Is there anyway for
> finding out the same for a USB mass storage device?

Why would you want to know this information for a controller device that
acts like a scsi one, not an IDE one (that's what usb storage devices
do...)

thanks,

greg k-h
