Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWGGGMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWGGGMr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 02:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWGGGMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 02:12:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:11189 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751166AbWGGGMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 02:12:47 -0400
Date: Fri, 7 Jul 2006 08:12:00 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Scott J. Harmon" <harmon@ksu.edu>
cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.17.4
In-Reply-To: <44AD9499.7040701@ksu.edu>
Message-ID: <Pine.LNX.4.61.0607070811270.11617@yvahk01.tjqt.qr>
References: <20060706222704.GB2946@kroah.com> <20060706222841.GD2946@kroah.com>
 <44AD9229.6010301@ksu.edu> <20060706224614.GA3520@suse.de> <44AD9499.7040701@ksu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>  		case PR_SET_DUMPABLE:
>>>> -			if (arg2 < 0 || arg2 > 2) {
>>>> +			if (arg2 < 0 || arg2 > 1) {
>>>>  				error = -EINVAL;
>>>>  				break;
>>>>  			}
>>> Just curious as to why this isn't just
>>> ...
>>> 			if (arg2 != 1) {
>>> ...
>> 
>> Because that would be incorrect :)
>
>DOH!
>/me hides under a rock

That's quite a good one.


Jan Engelhardt
-- 
