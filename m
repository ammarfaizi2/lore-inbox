Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUIOGrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUIOGrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUIOGrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:47:14 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:52930
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261711AbUIOGqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:46:18 -0400
Message-ID: <4147E525.4000405@ppp0.net>
Date: Wed, 15 Sep 2004 08:45:57 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Greg KH <greg@kroah.com>, Robert Love <rml@ximian.com>,
       Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
References: <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org> <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org> <20040915034229.GA30747@kroah.com> <20040915044830.GA4919@hockin.org> <20040915050904.GA682@kroah.com> <20040915062129.GA9230@hockin.org>
In-Reply-To: <20040915062129.GA9230@hockin.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
> ACPI events might come out of a kobject "/sys/devices/acpi" with an event
> "event" and payload "button/power 00000000 00000001" or whatever the
> actual values work out to be.
> 
> What's insane about that?  Currently we have a separate /proc/acpi/event
> file which spits out "button/power 00000000 00000001".
> 

What's wrong about fixing acpi to have something like 
/sys/devices/acpi/buttons/power/, that spits out the event?
Just curious...

Jan
