Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWARCK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWARCK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWARCK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:10:59 -0500
Received: from ms-smtp-01-smtplb.tampabay.rr.com ([65.32.5.131]:40139 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751362AbWARCK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:10:59 -0500
Message-ID: <43CDA3B0.2030503@cfl.rr.com>
Date: Tue, 17 Jan 2006 21:10:56 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Loftis <mloftis@wgops.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com> <43CD8A19.3010100@cfl.rr.com> <7A7A0F7F294BB08D7CDA264C@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <7A7A0F7F294BB08D7CDA264C@d216-220-25-20.dynip.modwest.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis wrote:

> What about I said was inaccurate?  I never said that it increases 
> exponentially or anything like that, just that it does increase, which 
> you've proven.  I was speaking in the case of a RAID-5 set, where the 
> minimum is 3 drives, so every additional drive increases the chance of 
> a double fault condition.  Now if we're including mirrors and 
> stripes/etc, then that means we do have to look at the 2 spindle case, 
> but the third spindle and beyond keeps increasing.  If you've a 1% 
> failure rate, and you have 100+ drives, chances are pretty good you're 
> going to see a failure. Yes it's a LOT more complicated than that.
>

I understood you to be saying that a raid-5 was less reliable than a 
single disk, which it is not.  Maybe I did not read correctly.  Yes, a 3 
+ n disk raid-5 has a higher chance of failure than a 3 disk raid-5, but 
only slightly so, and in any case, a 3 disk raid-5 is FAR more reliable 
than a single drive, and only slightly less reliable than a two disk 
raid-1 ( though you get 3x the space for only 50% higher cost, so 6x 
cheaper cost per byte of storage ). 




