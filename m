Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTDLWil (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 18:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbTDLWik (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 18:38:40 -0400
Received: from ip68-4-102-197.oc.oc.cox.net ([68.4.102.197]:62088 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id S261413AbTDLWik (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 18:38:40 -0400
Date: Sat, 12 Apr 2003 15:50:25 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Timothy Miller <tmiller10@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Page compression in lieu of swap?
Message-ID: <20030412225025.GA4721@ip68-101-124-193.oc.oc.cox.net>
References: <000d01c30143$ccf54ad0$6801a8c0@epimetheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d01c30143$ccf54ad0$6801a8c0@epimetheus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 06:35:19PM -0400, Timothy Miller wrote:
> Given the hideous amount of time required to access a disk, especially when
> something else wants to access it, could there be a benefit to "swapping"
> pages by compressing them to somewhere else in memory?  If we could achieve,
[snip]
> 
> Comments?

This has been done before, on (Classic) Mac OS (the program's name was
RAM Doubler). It was *far* faster than Apple's swapping implementation,
although I don't know how much of that was due to the compression and
how much was due to Apple's horrid virtual memory implementation back in
the day. It also had some stability problems, but that could have been
due to the implementation quality rather than to the overall approach.

-Barry K. Nathan <barryn@pobox.com>
