Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVFWFXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVFWFXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVFWFXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:23:32 -0400
Received: from saturn.billgatliff.com ([209.251.101.200]:6847 "EHLO
	saturn.billgatliff.com") by vger.kernel.org with ESMTP
	id S262157AbVFWFW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:22:58 -0400
Message-ID: <42BA471E.7010208@billgatliff.com>
Date: Thu, 23 Jun 2005 00:22:38 -0500
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
References: <200506222208.58494.david-b@pacbell.net>
In-Reply-To: <200506222208.58494.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David:

David Brownell wrote:

>The downside of "disable-and-remove-later" is that it becomes
>too easy to just re-enable the Kconfig stuff rather than just
>fixing the userspace bugs.  Expecting userspace to change at
>any point before it absolutely _must_ tends to be a formula
>for userspace never changing, sadly enough.  
>
>If 2.6.13 doesn't remove devfs, when will it really go away?
>  
>

Good point.  I've come this far somewhat reluctantly, but can see that 
udev is a better long-term solution.  Once devfs is gone, it's easier 
for me to justify doing the work to go fully over to udev (GregKH, can 
you post a link or two to those "packages" you refer to?).

And also, once devfs is gone it's an easier economic decision for my 
customers, too: either they move ahead and get whatever new features 
that non-devfs kernels offer, or they do the work to keep the current 
stuff in the state they want it.  It's their call, I (sometimes) get 
paid either way...

And it isn't like just my customers would be in this situation, everyone 
will have to face it.  So it's "fair" for everyone.

So, I guess I'm into the "say goodbye to devfs" camp now.  In case 
anyone asks, that is.  :^)


b.g.

-- 
Bill Gatliff
Build a man a fire, and he's warm for the rest of the night.
Set a man on fire, and he's warm for the rest of his life.
   -- Anonymous
bgat@billgatliff.com

