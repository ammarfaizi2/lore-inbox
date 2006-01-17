Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWAQX2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWAQX2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWAQX2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:28:08 -0500
Received: from free.wgops.com ([69.51.116.66]:42505 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S932101AbWAQX2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:28:06 -0500
Date: Tue, 17 Jan 2006 16:27:39 -0700
From: Michael Loftis <mloftis@wgops.com>
To: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
Message-ID: <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <E1EywcM-0004Oz-IE@laurel.muq.org>
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 17, 2006 1:35:46 PM -0600 Cynbe ru Taren <cynbe@muq.org> wrote:

>
> Just in case the RAID5 maintainers aren't aware of it:
>
> The current Linux kernel RAID5 implementation is just
> too fragile to be used for most of the applications
> where it would be most useful.
>
> In principle, RAID5 should allow construction of a
> disk-based store which is considerably MORE reliable
> than any individual drive.

Absolutely not.  The more spindles the more chances of a double failure. 
Simple statistics will mean that unless you have mirrors the more drives 
you add the more chance of two of them (really) failing at once and choking 
the whole system.

That said, there very well could be (are?) cases where md needs to do a 
better job of handling the world unravelling.
