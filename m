Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbUB0Qpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUB0Qpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:45:44 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:36496 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263043AbUB0Qpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:45:43 -0500
Message-ID: <403F7431.80608@backtobasicsmgmt.com>
Date: Fri, 27 Feb 2004 09:45:37 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: S390 block devs on !s390.
References: <20040227135728.GA15016@redhat.com>
In-Reply-To: <20040227135728.GA15016@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> This is probably useless on x86 for eg..
> (Everything else in this file is dependant on some other s390 feature,
>  so only this one shows up).  Too bad the drivers/s390/block stuff gets
> source'd at all on !s390.

Doesn't the config language support wrapping the entire KConfig file (or 
even a higher level one) with "if ARCH_S390"? All that does is add a 
"depends ARCH_S390" to everything in the file, but it would sure be a 
lot easier to maintain.
