Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbUBXAht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUBXAht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:37:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:37845 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262107AbUBXAhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:37:47 -0500
Date: Mon, 23 Feb 2004 16:27:03 -0800
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3rc4 ali1535 i2c driver rmmod oops.
Message-ID: <20040224002703.GB24225@kroah.com>
References: <20040218031544.GB26304@redhat.com> <20040218040153.GB6729@kroah.com> <20040221081953.60fe4165.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221081953.60fe4165.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 08:19:53AM +0100, Jean Delvare wrote:
> > Oh nevermind, that's just a dumb driver.  It's doing a release_region
> > on memory it didn't get.  Stupid, stupid, stupid...
> 
> While we're at it, what about fixing two other drivers that obviously
> have the same problem?
> 
> (BTW I didn't get an oops as I tried reproducing the problem, only a
> "Trying to free nonexistent resource" in dmesg.)
> 
> I'm backporting these fixes to the lm_sensors2 CVS repository at the
> moment, thanks for pointing them out.

Applied, thanks.

greg k-h
