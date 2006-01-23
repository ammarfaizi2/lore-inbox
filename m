Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWAWFYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWAWFYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWAWFYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:24:00 -0500
Received: from free.wgops.com ([69.51.116.66]:32271 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S932411AbWAWFX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:23:59 -0500
Date: Sun, 22 Jan 2006 22:23:43 -0700
From: Michael Loftis <mloftis@wgops.com>
To: "Barry K. Nathan" <barryn@pobox.com>, Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
In-Reply-To: <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
References: <200601212108.41269.a1426z@gawab.com>
 <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
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



--On January 22, 2006 11:55:37 AM -0800 "Barry K. Nathan" 
<barryn@pobox.com> wrote:

> On 1/21/06, Al Boldi <a1426z@gawab.com> wrote:
>> A long time ago, when i was a kid, I had dream. It went like this:
> [snip]
>
> FWIW, Mac OS X is one step closer to your vision than the typical
> Linux distribution: It has a directory for swapfiles -- /var/vm -- and
> it creates new swapfiles there as needed. (It used to be that each
> swapfile would be 80MB, but the iMac next to me just has a single 64MB
> swapfile, so maybe Mac OS 10.4 does something different now.)
/var/vm/swap*
 64M    swapfile0
 64M    swapfile1
128M    swapfile2
256M    swapfile3
512M    swapfile4
512M    swapfile5
1.5G    total

However only the first 5 are in use.  the 6th just represents the peak swap 
usage on this machine.  This is on 10.4.
