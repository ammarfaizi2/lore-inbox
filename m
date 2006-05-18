Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWERVOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWERVOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWERVOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:14:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:7310 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751327AbWERVOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:14:14 -0400
Date: Thu, 18 May 2006 14:11:48 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <jdelvare@nerim.net>
Cc: Chris Wright <chrisw@sous-sol.org>, Randy Dunlap <rdunlap@xenotime.net>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       stable@kernel.org
Subject: Re: [stable] Re: [PATCH 07/22] [PATCH] smbus unhiding kills thermal management
Message-ID: <20060518211148.GA30929@kroah.com>
References: <20060517221312.227391000@sous-sol.org> <20060517221358.617565000@sous-sol.org> <20060518225310.eea9b93d.jdelvare@nerim.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518225310.eea9b93d.jdelvare@nerim.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 10:53:10PM +0200, Jean Delvare wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > ------------------
> > 
> > Do not enable the SMBus device on Asus boards if suspend is used.  We do
> > not reenable the device on resume, leading to all sorts of undesirable
> > effects, the worst being a total fan failure after resume on Samsung P35
> > laptop.
> > 
> > Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> As the i2c and hwmon maintainer, I wish to thank Carl-Daniel for his
> good work on this, and this patch is
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Note that this patch should fix bug #6449.

Thanks, I've added this info to the patch and will show up in the final
changelog.

greg k-h
