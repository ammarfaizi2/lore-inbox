Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVCDJ36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVCDJ36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCDJ1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:27:04 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:32618 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262711AbVCDJYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:24:23 -0500
Message-ID: <42282944.6020006@yahoo.com.au>
Date: Fri, 04 Mar 2005 20:24:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <20050302205826.523b9144.davem@davemloft.net>	<4226C235.1070609@pobox.com>	<20050303080459.GA29235@kroah.com>	<4226CA7E.4090905@pobox.com>	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>	<422751C1.7030607@pobox.com>	<20050303181122.GB12103@kroah.com>	<20050303151752.00527ae7.akpm@osdl.org>	<20050303234523.GS8880@opteron.random>	<20050303160330.5db86db7.akpm@osdl.org>	<20050304025746.GD26085@tolot.miese-zwerge.org>	<20050303213005.59a30ae6.akpm@osdl.org>	<1109924470.4032.105.camel@tglx.tec.linutronix.de> <20050304005450.05a2bd0c.akpm@osdl.org>
In-Reply-To: <20050304005450.05a2bd0c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:

> 
>>I don't see that the releases are stable. They are defined stable by
>>proclamation. 
> 
> 
> If they were stable we'd release the darn things!  *obviously* -rc kernels
> are expected to still have problems.
> 

Release the -rc kernel when it is stable. Then people will test them,
and then they'll hopefully catch the small annoyances that give our
real releases a bad reputation.

> -rc just means "please start testing", not "deploy me on your corporate
> database server".
> 
> People are smart enough to know that -rc3 will be less buggy than -rc1.
> 
> And if they're worried about bugs then why are they running -rc's at all?
> 

Well they aren't in the current scheme. When doing real release candidates,
they'll test* because they _are_ worried about bugs, and testing an -rc is
an easy way to get all your little compilation problems fixed, and all your
strage usb drivers working again for the realease. And without someone
rewriting the page table code in the meantime.

I could be completely wrong, but that's my feeling.

* Maybe not on their live corporate database server though

