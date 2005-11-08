Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVKHDtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVKHDtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVKHDtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:49:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932465AbVKHDtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:49:09 -0500
Date: Mon, 7 Nov 2005 19:48:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Neil Brown <neilb@suse.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Subject: Re: [OT] Re: [PATCH 3/18] allow callers of seq_open do allocation
 themselves
In-Reply-To: <20051108033040.GQ7992@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0511071945510.3247@g5.osdl.org>
References: <E1EZInj-0001Eh-9T@ZenIV.linux.org.uk> <20051107190340.129bc8c3.rdunlap@xenotime.net>
 <17264.6769.472245.973213@cse.unsw.edu.au> <20051108033040.GQ7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Nov 2005, Al Viro wrote:
> 
> git format-patch and used by git applymbox and friends...

Note that git applymbox can (and normally does) take the date in regular 
RFC 822 email format too, so it's really git format-patch that is the 
culprit here. It _could_ try to turn it back into a regular date, but just 
uses the git internal format because it's easy, lazy, and unambigious.

The easy and lazy parts are probably not very strong arguments. The 
unambigious part is the thing that makes it a killer format.

		Linus
