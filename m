Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUA3TS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUA3TS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:18:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:41625 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263448AbUA3TS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:18:56 -0500
Date: Fri, 30 Jan 2004 11:18:53 -0800
From: Greg KH <greg@kroah.com>
To: Markus Schaber <schabios@logi-track.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Errors with USB Disk
Message-ID: <20040130191853.GB7173@kroah.com>
References: <20040130122324.7ac7ef34.schabios@logi-track.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130122324.7ac7ef34.schabios@logi-track.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:23:24PM +0100, Markus Schaber wrote:
> Hi,
> 
> I'm trying to use an USB Disk (IDE Disk in external USB Case), but
> strange file system errors occurend and tools as dosfsck reproducably
> hang.
> 
> kingfisher:/home/schabi# uname -a
> Linux kingfisher 2.6.0 #1 Wed Dec 24 19:16:00 CET 2003 i686 GNU/Linux

Please try 2.6.1 at the least, and if you can 2.6.2-rc2.  There's been a
lot of cleanups and minor fixes in the USB and scsi area in those
kernels.

thanks,

greg k-h
