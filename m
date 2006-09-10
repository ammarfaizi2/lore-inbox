Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWIJSkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWIJSkO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 14:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWIJSkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 14:40:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:661 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932425AbWIJSkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 14:40:12 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>,
       akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru, liste@jordet.net
In-Reply-To: <20060910002112.GA20672@kroah.com>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
	 <1157848272.6877.108.camel@localhost.localdomain>
	 <20060910002112.GA20672@kroah.com>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 14:40:46 -0400
Message-Id: <1157913647.5076.174.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 17:21 -0700, Greg KH wrote:
> On Sun, Sep 10, 2006 at 01:31:12AM +0100, Alan Cox wrote:
> > VIA have always told me that "ACPI handles this" and we don't need
> > quirks. Various chips have different IRQ routing logic and it's all a
> > bit weird if we don't use ACPI and/or BIOS routing.
> 
> So why isn't acpi handling all of this for us?  Do people not want to
> use acpi for some reason?

Some applications such as realtime audio and probably gaming require
ACPI to be disabled, as it causes horrible latency problems.  This
applies equally to Linux and Windows.

Lee

