Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVJaJHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVJaJHc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVJaJHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:07:32 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:17800 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932204AbVJaJHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:07:31 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4365DE60.9050100@s5r6.in-berlin.de>
Date: Mon, 31 Oct 2005 10:05:36 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: art@usfltd.com, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: kernel-2.6.14-git1 - ieee1394 rev.1334 compilation problem !
References: <200510301913.AA59179280@usfltd.com>
In-Reply-To: <200510301913.AA59179280@usfltd.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: (-1.101) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

art wrote:
>>>kernel-2.6.14-git1 - ieee1394 rev.1334 compilation problem !
>>>....
>>>  CC [M]  drivers/ieee1394/csr.o
>>>  CC [M]  drivers/ieee1394/nodemgr.o
>>>drivers/ieee1394/nodemgr.c: In function ‘nodemgr_suspend_ne’:
>>>drivers/ieee1394/nodemgr.c:1295: error: too many arguments to function ‘ud->device.driver->suspend’
[...]

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=7fff5a1d2ea4c7abc8713df31f2222a5cfb6c4b2;hp=347ece6b583c19cdf67e521dcb5ae3ebf2c1ecdd;hb=9480e307cd88ef09ec9294c7d97ebec18e6d2221;f=drivers/ieee1394/nodemgr.c

>>I don't see that error with 2.6.14-git1 or -git2.
>>Did you download and apply -git1 ?
[...]
> Randy same error with git1 and git2
> 1 - unpack kernel
> 2 - apply paches
> 3 - replace drivers\ieee1394 with svn rev.1334 - version
> 4 - compile
> 
> (looks like svn rev.1334 need some changes)

The last revision from svn.linux1394.org does not compile in the current
kernel anymore. Just use the 1394 drivers in Linus' tree. They are up to 
date except for an sbp2 cleanup which is to be merged RSN:
http://marc.theaimsgroup.com/?l=linux1394-devel&m=112785243602303
http://marc.theaimsgroup.com/?l=linux1394-devel&m=112785249412770
plus an sbp2 bugfix which is neither in SVN nor merged yet:
http://marc.theaimsgroup.com/?l=linux1394-devel&m=113006758030022

> btw
> is www.linux1394.org and svn://svn.linux1394.org/ieee1394 --- alive ???

The site is down and/or its DNS entries are gone again.
-- 
Stefan Richter
-=====-=-=-= =-=- =====
http://arcgraph.de/sr/
