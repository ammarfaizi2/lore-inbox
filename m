Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWFKEOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWFKEOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 00:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWFKEOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 00:14:03 -0400
Received: from ns1.suse.de ([195.135.220.2]:4292 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932530AbWFKEOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 00:14:01 -0400
Date: Sat, 10 Jun 2006 21:11:25 -0700
From: Greg KH <greg@kroah.com>
To: Anne Thrax <foobarfoobarfoobar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removal of security/root_plug.c
Message-ID: <20060611041125.GA15655@kroah.com>
References: <448B5449.2030605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448B5449.2030605@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 07:22:49PM -0400, Anne Thrax wrote:
> Hello all,
> 
> Apparently security/root_plug.c was written for a Linux Journal article,
> and while it does do a good job of explaining LSM, I don't see much use for
> it in the mainstream kernel. I suggest that it be removed, because I don't
> think that it serves much purpose. I doubt that anyone actually uses this,
> for if they did, I think that it would be modified and have many additions.
> Even the author states that it is just a starting point. Maybe the article
> (if Linux Journal is okay with it) along with the code should be moved to
> Documentation/?

No, it should stay for the same reasons I gave a month or so ago on this
list when someone asked the same question (please search the archives
for details.)

And surprisingly, people actually use this lsm module for real...

thanks,

greg k-h
