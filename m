Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUCAVIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 16:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUCAVIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 16:08:12 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:19895 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S261437AbUCAVIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 16:08:09 -0500
Message-ID: <4043A633.5090208@backtobasicsmgmt.com>
Date: Mon, 01 Mar 2004 14:08:03 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Nigel Kukard <nkukard@lbsd.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.3] Sysfs breakage - tun.ko
References: <4043938C.9090504@lbsd.net> <40439B03.4000505@backtobasicsmgmt.com> <20040301124723.P22989@build.pdx.osdl.net>
In-Reply-To: <20040301124723.P22989@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> Why don't you use:
> 	.devfs_name = "net/tun",

That seems fine, if it will do the job.

> Or fix userspace apps?  Or switch to udev with devfs rules emulated and a
> rule for the tun/tap driver?

This is a stable kernel series; these kinds of userspace-breakage 
changes are not supposed to happen. Personally I have already started 
migrating my systems to udev, but it will take some time to complete 
that. Regardless, this would be a userspace-incompatible change if using 
.devfs_name won't do the job.
