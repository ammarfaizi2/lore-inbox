Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVDXFmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVDXFmz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 01:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVDXFmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 01:42:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:52909 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262264AbVDXFmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 01:42:53 -0400
Date: Sat, 23 Apr 2005 22:42:31 -0700
From: Greg KH <greg@kroah.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050424054231.GA25561@kroah.com>
References: <200504220956.43883.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504220956.43883.petkov@uni-muenster.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 09:56:43AM +0200, Borislav Petkov wrote:
> On Thursday 21 April 2005 02:59, you wrote:
> <snip>
> Hello,
> 
> [build.log]
> ...
> drivers/usb/storage/debug.c: In function `usb_stor_show_sense':
> drivers/usb/storage/debug.c:166: warning: implicit declaration of function
> `scsi_sense_key_string'
> drivers/usb/storage/debug.c:166: warning: assignment makes pointer from
> integer without a cast
> drivers/usb/storage/debug.c:167: warning: implicit declaration of function
> `scsi_extd_sense_format'
> drivers/usb/storage/debug.c:167: warning: assignment makes pointer from
> integer without a cast
> ...
> 
> Hmm, actually I've already sent the trivial patch below for this to Andrew a
> few weeks ago and he included it in mm but somehow it is not there..

What is your .config that generates this?  What arch?

thanks,

greg k-h
