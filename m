Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWB0X1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWB0X1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWB0X1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:27:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:59115 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751775AbWB0X1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:27:39 -0500
Date: Mon, 27 Feb 2006 14:00:38 -0800
From: Greg KH <gregkh@suse.de>
To: Benjamin LaHaise <bcrl@kvack.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227220038.GA19899@suse.de>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <20060227200107.GA14011@kvack.org> <20060227201323.GB12111@suse.de> <20060227202232.GC26559@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227202232.GC26559@tuxdriver.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 03:22:36PM -0500, John W. Linville wrote:
> On Mon, Feb 27, 2006 at 12:13:23PM -0800, Greg KH wrote:
> 
> > Again, I agree.  People (including Linus) have said they will accept
> > something like include/abi/ (it was a different name last time that I
> > can't remember), but no one has done the work yet...
> 
> Whether or not something is in include/abi/*.h should be a factor in
> classifying it as "stable", "unstable", etc...?

Sure, but lots of our "ABI" is not encoded in header files (think
sysfs), so this will not work for everything.

thanks,

greg k-h
