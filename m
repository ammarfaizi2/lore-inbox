Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVCCUAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVCCUAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVCCT4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:56:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26533 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262169AbVCCTwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:52:36 -0500
Message-ID: <42276AF5.3080603@pobox.com>
Date: Thu, 03 Mar 2005 14:52:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>  <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>  <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>  <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>  <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>  <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>  <20050303170808.GG4608@stusta.de> <1109877336.4032.47.camel@tglx.tec.linutronix.de> <Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 3 Mar 2005, Thomas Gleixner wrote:
> 
>>It still does not solve the problem of "untested" releases. Users will
>>still ignore the linus-tree-rcX kernels. 
> 
> 
> .. and maybe that problem is unsolvable. People certainly argued 
> vehemently that anything we do to try to make test releases (renaming etc) 
> won't help.
> 
> So what do you do if you find an unsolvable problem? You don't solve it: 
> you make sure it's not a show-stopper.

I disagree it's unsolvable:

1) At some point in the -rc cycle, you put your foot down and say 
"nothing but bugfixes."

2) Indicate this foot-stomp in a manner that a script can easily notice.

That's all the 2.4.x's -pre/-rc accomplishes.  It encourages people to 
test, by telling them when their testing would be most useful.

	Jeff


