Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWA0TkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWA0TkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWA0TkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:40:21 -0500
Received: from tornado.reub.net ([202.89.145.182]:30858 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932482AbWA0TkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:40:20 -0500
Message-ID: <43DA7722.6060107@reub.net>
Date: Sat, 28 Jan 2006 08:40:18 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.5 (Windows/20060124)
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>	<43D7567E.60003@reub.net>	<20060126053941.GA13361@kroah.com>	<43DA161C.1070404@reub.net>	<20060127172720.GB13320@kroah.com> <20060127094947.7439935d.zaitcev@redhat.com>
In-Reply-To: <20060127094947.7439935d.zaitcev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2006 6:49 a.m., Pete Zaitcev wrote:
> On Fri, 27 Jan 2006 09:27:20 -0800, Greg KH <greg@kroah.com> wrote:
> 
>> How about just disabling USB legacy support in the bios completly?
>> Unless you have a USB keyboard that you need for a bootloader screen or
>> BIOS configuration, that's the recommended setting (due to all of the
>> horrible BIOS USB bugs we have seen over the years.)
> 
> I disagree with the "unless". Just disable it, period. Most of the time,
> disabling "USB Legacy Support" leaves the bootloader fully operational.
> I always recommend it as the first course of action in cases like this one.

That seemed to clear the error message, and my 1.1 devices at least, still work 
fine.  Perhaps the error message could be changed to point users in the right 
direction to fixing this, perhaps something more like "0000:00:1d.7 EHCI: BIOS 
handoff failed (BIOS bug?  Try disabling legacy USB support in BIOS if it is 
enabled)"

Anyway, thanks for the hint (and sorry for the noise).

reuben
