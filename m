Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUIKUAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUIKUAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268299AbUIKUAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:00:00 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:46273 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S268293AbUIKT76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 15:59:58 -0400
Message-ID: <4143593D.9050402@backtobasicsmgmt.com>
Date: Sat, 11 Sep 2004 12:59:57 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev: udevd shall inform us abot trouble
References: <200409081018.43626.vda@port.imtp.ilyichevsk.odessa.ua> <200409111943.21225.vda@port.imtp.ilyichevsk.odessa.ua> <41433A68.7090403@backtobasicsmgmt.com> <200409112122.36068.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409112122.36068.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> As a user, I prefer to be able to use device right away after
> modprobe. Imagine ethN appearing "sometime after" modprobe.
> Would you like such behavior?

Imagine that the device isn't plugged in when modprobe is run, but is 
plugged in later.

Imagine that the device is plugged in when modprobe is run, but some 
intermediate device (for example a USB hub) is not working, so when you 
correct if the device appears.

There are many more scenarios where true hotplug-based initialization 
makes more sense than otherwise.
