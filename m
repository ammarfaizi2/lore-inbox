Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVDEV4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVDEV4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVDEVzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:55:51 -0400
Received: from outbound04.telus.net ([199.185.220.223]:27273 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id S261672AbVDEVvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:51:54 -0400
Subject: Re: ... no drivers for IEEE1394 product 0x/0x/0x in kernel
	2.6.12-rc1-bk6
From: Bob Gill <gillb4@telusplanet.net>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050405031423.GA10733@ip68-4-98-123.oc.oc.cox.net>
References: <1112667776.6675.1.camel@localhost.localdomain>
	 <20050405031423.GA10733@ip68-4-98-123.oc.oc.cox.net>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 15:51:25 -0600
Message-Id: <1112737885.9514.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I don't use CONFIG_DEVFS_FS as it tends to break things here
(and I found wasn't necessary for things to work, in fact it got in the
way of some things working, some of the autodetect/hotplug peripherels
didn't like it).  Thank you for the reply though.
Bob

On Mon, 2005-04-04 at 20:14 -0700, Barry K. Nathan wrote:
> On Mon, Apr 04, 2005 at 08:22:56PM -0600, Bob Gill wrote:
> > Hi.  I recently built 2.6.12-rc1-bk6.  The kernel seems to be tripping
> > over sbp2.  The error messages keep right on rolling till I hit the
> > reboot button (I let it run for more than 90 seconds last time).
> > 2.6.11.6 builds/runs without any problems.
> [snip]
> 
> I was having the same problem on a system of mine too, but it went away
> after I disabled CONFIG_DEVFS_FS. You didn't include enough of your
> .config for me to be able to tell if that is at all relevant in your
> case however.
> 
> -Barry K. Nathan <barryn@pobox.com>
-- 
Bob Gill <gillb4@telusplanet.net>

