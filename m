Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbWBTWDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWBTWDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWBTWDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:03:45 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:17061 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932634AbWBTWDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:03:44 -0500
Message-ID: <55990.128.237.252.29.1140472824.squirrel@128.237.252.29>
In-Reply-To: <1140472618.29789.12.camel@lycan.lan>
References: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29> 
    <20060219191552.GB4971@stusta.de>
    <1140472618.29789.12.camel@lycan.lan>
Date: Mon, 20 Feb 2006 17:00:24 -0500 (EST)
Subject: Re: kernel panic with unloadable module support... SMP
From: "George P Nychis" <gnychis@cmu.edu>
To: azarah@nosferatu.za.org
Cc: "Adrian Bunk" <bunk@stusta.de>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

actually, what I am stating is correct, and yes there is 2.6.15-r_ in portage for vanilla-sources:

monster hedpe # emerge -pv vanilla-sources

These are the packages that I would merge, in order:

Calculating dependencies ...done!
[ebuild   R   ] sys-kernel/vanilla-sources-2.6.15.1  -build -doc -symlink 0 kB 

Total size of downloads: 0 kB

That is using ~x86 keyword.

- George


> On Sun, 2006-02-19 at 20:15 +0100, Adrian Bunk wrote:
>> On Sun, Feb 19, 2006 at 02:11:17PM -0500, George P Nychis wrote:
>> 
>>> Hi,
>> 
>> Hi George,
>> 
>>> Whenever I compiled unloadable module support into my 2.6.15-r1
>>> kernel, my kernel panic's when booting up when it tries to load a
>>> module for the first time.
>>> 
>>> I had this problem back with the 2.6.14 kernel, but figured it may
>>> have been solved since then so I tried it... and still fails.
>>> 
>>> Unloadable module support would be very helpful to me.
>>> 
>>> I am using an intel p4 3.0ghz with SMP support built into the kernel.
>>>  ...
>> 
>> What is 2.6.15-r1 for a kernel? Is your problem present in an unmodified
>> 2.6.16-rc4 kernel from ftp.kernel.org?
>> 
> 
> If it was gentoo's vanilla-sources (which is just that - vanilla 
> kernel.org sources), then no 2.6.x version ever packaged by Gentoo, so 
> either he had gentoo-sources, which is something totally different (and 
> not vanilla sources as he specified), or there is a naming issue ...
> 
> 
> Regards,
> 
> -- Martin Schlemmer
> 
> 


-- 

