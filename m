Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUIOGtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUIOGtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUIOGtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:49:01 -0400
Received: from [66.35.79.110] ([66.35.79.110]:6333 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261474AbUIOGrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:47:48 -0400
Date: Tue, 14 Sep 2004 23:47:35 -0700
From: Tim Hockin <thockin@hockin.org>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Greg KH <greg@kroah.com>, Robert Love <rml@ximian.com>,
       Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915064735.GA11272@hockin.org>
References: <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org> <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org> <20040915034229.GA30747@kroah.com> <20040915044830.GA4919@hockin.org> <20040915050904.GA682@kroah.com> <20040915062129.GA9230@hockin.org> <4147E525.4000405@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4147E525.4000405@ppp0.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 08:45:57AM +0200, Jan Dittmer wrote:
> Tim Hockin wrote:
> >
> >ACPI events might come out of a kobject "/sys/devices/acpi" with an event
> >"event" and payload "button/power 00000000 00000001" or whatever the
> >actual values work out to be.
> >
> >What's insane about that?  Currently we have a separate /proc/acpi/event
> >file which spits out "button/power 00000000 00000001".
> >
> 
> What's wrong about fixing acpi to have something like 
> /sys/devices/acpi/buttons/power/, that spits out the event?
> Just curious...

You'd still need to spit out a payload with the status.  Interesting idea
for the evolution of acpi, though...
