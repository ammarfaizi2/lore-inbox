Return-Path: <linux-kernel-owner+w=401wt.eu-S932153AbXAFUU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbXAFUU4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbXAFUUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:20:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:43376 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbXAFUUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:20:55 -0500
Message-ID: <45A0048B.8090503@zytor.com>
Date: Sat, 06 Jan 2007 12:20:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       "J.H." <warthog9@kernel.org>, Willy Tarreau <w@1wt.eu>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz>	<20061216094421.416a271e.randy.dunlap@oracle.com>	<20061216095702.3e6f1d1f.akpm@osdl.org>	<458434B0.4090506@oracle.com>	<1166297434.26330.34.camel@localhost.localdomain>	<20061219063413.GI24090@1wt.eu>	<1166511171.26330.120.camel@localhost.localdomain>	<20070106103331.48150aed.randy.dunlap@oracle.com>	<459FF60D.7080901@zytor.com>	<45A002FE.8060700@garzik.org> <20070106121728.1b2946dc.akpm@osdl.org>
In-Reply-To: <20070106121728.1b2946dc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>
>> Unfortunately that affects all three of: dcache, icache, and mbcache. 
>> Maybe we could split that sysctl in two (Andrew?), so that one sysctl 
>> affects dcache/icache and another affects mbcache.
>>
> 
> That would be simple enough to do, if someone can demonstrate a
> need.
> 

Is there an easy way to find out how much memory is occupied by the 
various caches?  If so I should be able to tell you in a couple of days.

	-hpa
