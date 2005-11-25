Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbVKYK7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVKYK7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 05:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVKYK7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 05:59:22 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:41614 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751443AbVKYK7V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 05:59:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m9WdixAt0EXn2e/gGv2cbYMvs/RXuqEoM7kao20Hq9i2Cuyh5BjtzrNFWyezo4x6294Zq5MZvPQi5blDCTNisIEqoe5CcooWlNDnJpwUyOJrgLAdKP8rxUEzfuQLxYe0jzAYgjkgswLWjmRY1Rejc2VS1kSmTYQ18AnWi20qRls=
Message-ID: <5a4c581d0511250259i3e412c92i57a0bfe82144c81a@mail.gmail.com>
Date: Fri, 25 Nov 2005 11:59:20 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Zhu Yi <yi.zhu@intel.com>
Subject: Re: ipw2200 in 2.6.15-rc2-git4 warns about improper NETDEV_TX_BUSY retcode
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <1132889013.24413.5.camel@debian.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0511241538s496adee9s249cd038501545c9@mail.gmail.com>
	 <1132889013.24413.5.camel@debian.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/05, Zhu Yi <yi.zhu@intel.com> wrote:
> On Fri, 2005-11-25 at 00:38 +0100, Alessandro Suardi wrote:
> > Dell Latitude D610, FC4 base distro, kernel is:
> >
> > [asuardi@sandman ~]$ cat /proc/version
> > Linux version 2.6.15-rc2-git4 (asuardi@sandman) (gcc version 4.0.1
> > 20050727 (Red Hat 4.0.1-5)) #2 Fri Nov 25 00:15:46 CET 2005
> >
> > Onboard wireless card as detected by kernel is:
> > ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
> >
> >  and I placed the 2.4 firmware from sourceforge.net in /lib/firmware.
> >
> > ifup eth1 yields this message:
> >
> > eth1: NETDEV_TX_BUSY returned; driver should report queue full via
> > ieee_device->is_queue_full.
>
> Please use the patch here. It will be push to upstream very soon.
> http://bughost.org/bugzilla/show_bug.cgi?id=808

The offsets of the patch are off by several hundred lines,
 however the patch itself works fine. Thanks !

--alessandro

 "So much can happen by accident
  No rhyme, no reason - no one's innocent"

   (Steve Wynn - "Under The Weather")
