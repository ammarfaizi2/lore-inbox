Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWG3JFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWG3JFT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWG3JFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:05:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48555 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932076AbWG3JFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:05:17 -0400
Date: Sun, 30 Jul 2006 02:00:59 -0700
From: Greg KH <greg@kroah.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>,
       "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>
Subject: Re: Generic battery interface
Message-ID: <20060730090059.GC17759@kroah.com>
References: <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com> <20060728202359.GB5313@suse.cz> <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com> <20060729103613.GB7438@suse.cz> <41840b750607290432m6d302cdoae7f3eef869279d4@mail.gmail.com> <20060729120411.GA8285@suse.cz> <41840b750607290551kae4a7c7k9402c96e5b67e6a5@mail.gmail.com> <20060729134225.GA4882@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729134225.GA4882@suse.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 03:42:25PM +0200, Vojtech Pavlik wrote:
> On Sat, Jul 29, 2006 at 03:51:45PM +0300, Shem Multinymous wrote:
> > Given the current usage pattern of sysfs, is it still a bad idea for
> > it to carry device inodes?
>  
> That remains an open question.

No, that's a closed question.  It simply will not happen.  Linus vetoed
this years ago, for lots of different reasons that I can't recall at the
moment (namespaces, permissions, groups, and other things from what I
remember.)

Search the lkml archives if you are really curious...

thanks,

greg k-h
