Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWGMSsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWGMSsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWGMSsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:48:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:38312 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030287AbWGMSsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:48:20 -0400
Date: Thu, 13 Jul 2006 11:37:03 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Opinions on removing /proc/tty?
Message-ID: <20060713183703.GA31824@kroah.com>
References: <9e4733910607072256q65188526uc5cb706ec3ecbaee@mail.gmail.com> <20060708220414.c8f1476e.rdunlap@xenotime.net> <9e4733910607082220v754a000ak7e75ae4042a5e595@mail.gmail.com> <44B0D55D.2010400@gmail.com> <9e4733910607090645l236f17f1sb9778f0fc6c6ca01@mail.gmail.com> <20060709103529.bf8a46a4.rdunlap@xenotime.net> <44B191CF.2090506@gmail.com> <9e4733910607091744k273a7351l16abbcc6ff8c4bbd@mail.gmail.com> <20060711220117.GD663@kroah.com> <9e4733910607111532s3fc2bb52q3f0247a9f2289d4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910607111532s3fc2bb52q3f0247a9f2289d4e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 06:32:26PM -0400, Jon Smirl wrote:
> If you really want to stick with the one value model on the read-only
> attributes, how about a sysfs function that takes a variable and a
> string array of enum values. It creates a subdirectory named for the
> variable and makes attributes in the directory matching the names from
> the enum. The subdirectory avoids namespace collisions. The attributes
> are then managed like a set of radio buttons so that only one can be
> set non-zero at a time.  The driver read/write functions for the
> variable never knows this is going on, read/write just works with an
> index into the array.

That might be interesting.  Send a patch and I'll seriously consider it.

thanks,

greg k-h
