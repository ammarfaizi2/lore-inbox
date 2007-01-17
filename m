Return-Path: <linux-kernel-owner+w=401wt.eu-S1751464AbXAQXfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbXAQXfZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 18:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAQXfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 18:35:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:55349 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbXAQXfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 18:35:23 -0500
Date: Wed, 17 Jan 2007 15:35:45 -0800
From: Greg KH <greg@kroah.com>
To: Nicolas Bareil <nico@chdir.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.19.2 : Oops
Message-ID: <20070117233545.GA12717@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <873b6a6ji0.fsf@boz.loft.chdir.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873b6a6ji0.fsf@boz.loft.chdir.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 11:21:59AM +0100, Nicolas Bareil wrote:
> 
> Hello,
> 
> Since 2.6.19, I get the following Oops once a day, always with the same
> process, newspipe[1] which use a lot of CPU, threads and I/O.
> 
> The kernel is patched by Grsecurity. The ext3 filesystem is on a
> software RAID device (the two disks are SATA2). I tested the 
> hardware (RAM, SMART disks) but nothing seem problematic.

Can you reproduce it without the grsec patch applied?

thanks,

greg k-h
