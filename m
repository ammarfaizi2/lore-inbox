Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWIPG1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWIPG1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 02:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWIPG1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 02:27:24 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:6757 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932212AbWIPG1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 02:27:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZBNSXm3mHyMOyZaQT72Qb9K6TOgxUafQkRo35vbGj16M/2YZzm1JiJH0YW4poDLoXyOXpzybBDlu893mI2GtSpt/SpuEL3iT4zuWAsdqriiQ3t6ZDp9Ys/Ae/t/kXYmQ3fVvW29Pxd0TedNiOOgpVBvVl0TusGQqfTbTPfFuTJs=
Message-ID: <450B9940.5030609@gmail.com>
Date: Sat, 16 Sep 2006 15:27:12 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Tom Mortensen <tmmlkml@gmail.com>, linux-kernel@vger.kernel.org,
       jeff@garzik.org
Subject: Re: 2.4.x libata resync
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com> <20060916053713.GJ541@1wt.eu>
In-Reply-To: <20060916053713.GJ541@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Willy Tarreau wrote:
> On Fri, Sep 15, 2006 at 10:14:07PM -0700, Tom Mortensen wrote:
>> To Jeff Garzik & others,
>> I was wondering if there are any plans for another resync of the latest
>> 2.6.x libata changes back into the 2.4.x kernel?
> 
> When Jeff posted his last version (which got merged), he said that it
> would be his last work on this backport. I've been regularly checking
> what has changed in 2.6, because often some bugs are fixed, but I see
> that the code has considerably evolved since the last resync, and I'm
> not even sure that those bugfixes are needed for 2.4.
> 
> A full resync of latest 2.6 would require a considerable effort it seems.
> Do you encounter any problems right now ? I get very few feedback from
> SATA users in general.

I don't think it's gonna happen.  Later libata changes depend on a 
number of SCSI updates, which in turn are deeply dependent upon new 
driver model used in 2.6.  So, apart from bug fixes, there won't be 2.4 
resync.

-- 
tejun
