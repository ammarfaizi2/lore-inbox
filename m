Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbUAATwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 14:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbUAATwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 14:52:16 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:40069 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264553AbUAATwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 14:52:15 -0500
Message-ID: <3FF47AAA.7090903@myrealbox.com>
Date: Thu, 01 Jan 2004 11:53:14 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040101
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
References: <fa.flhsork.uka2hg@ifi.uio.no> <fa.hv9hpq7.1l1q9p3@ifi.uio.no>
In-Reply-To: <fa.hv9hpq7.1l1q9p3@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> On Thu, 2004-01-01 at 00:17, walt wrote:

>> ...I have  not been able to get udev working yet...

> Hmm, It works fine here?  I was under the impression that
 > it should _just_work_ if you have latest everything unstable...

Yes!  I want to confirm that it DOES 'just work' with this one
little thingy I missed:

I needed to add TWO boot flags because of the way I have my
kernel configured:  'nodevfs' AND 'devfs=nomount'.

Without the 'devfs=nomount' flag the kernel was starting devfsd
anyway, which keeps udev from working, apparently.

So, Greg, please be nice to Martin, who is working hard to
get gentoo people out of your mailbox.

Thanks to both of you, and Happy New Year!
