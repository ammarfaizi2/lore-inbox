Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUIOGxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUIOGxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUIOGx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:53:29 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:28611
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261426AbUIOGvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:51:03 -0400
Message-ID: <4147E649.1060306@ppp0.net>
Date: Wed, 15 Sep 2004 08:50:49 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Greg KH <greg@kroah.com>, Robert Love <rml@ximian.com>,
       Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
References: <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org> <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org> <20040915034229.GA30747@kroah.com> <20040915044830.GA4919@hockin.org> <20040915050904.GA682@kroah.com> <20040915062129.GA9230@hockin.org> <4147E525.4000405@ppp0.net> <20040915064735.GA11272@hockin.org>
In-Reply-To: <20040915064735.GA11272@hockin.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> On Wed, Sep 15, 2004 at 08:45:57AM +0200, Jan Dittmer wrote:
> 
>>Tim Hockin wrote:
>>
>>>ACPI events might come out of a kobject "/sys/devices/acpi" with an event
>>>"event" and payload "button/power 00000000 00000001" or whatever the
>>>actual values work out to be.
>>>
>>>What's insane about that?  Currently we have a separate /proc/acpi/event
>>>file which spits out "button/power 00000000 00000001".
>>>
>>
>>What's wrong about fixing acpi to have something like 
>>/sys/devices/acpi/buttons/power/, that spits out the event?
>>Just curious...
> 
> 
> You'd still need to spit out a payload with the status.  Interesting idea
> for the evolution of acpi, though...

Well, what's the status supposed to mean? Is this something like 
buttondown, buttonup, ...? Couldn't this be the 'event'. I mean that it 
is an event is kind of selfexplaining if it comes through the event layer.

Jan
