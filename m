Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbTLYUwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 15:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbTLYUwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 15:52:19 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:54410 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264359AbTLYUwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 15:52:18 -0500
Date: Thu, 25 Dec 2003 12:52:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.6.0-mjb1
Message-ID: <175850000.1072385528@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0312252019070.23168@student.dei.uc.pt>
References: <165810000.1072370137@[10.10.2.4]> <Pine.LNX.4.58.0312252019070.23168@student.dei.uc.pt>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'd be very interested in feedback from anyone willing to test on any
>> platform, however large or small.
> 
> It's working perfectly for me: in fact it's what I'm running right now.
> I'm running it on an Asus M3700N laptop...
> Any tests you want me to do, just e-mail asking them.

Cool - thanks. It probably doesn't get as much testing under memory 
pressure as it should on laptop-sized systems (though I do my best on
my own boxes). I'd be interested to see how it performs for people on 
desktop/laptops compared to virgin 2.6.0 - objrmap pays a little during
pageout for what it gains during regular usage. Just regular desktop
workload stuff, but measuring performance can be somewhat subjective
unless you have a more formal (and artificial) test. As long as it's
tangibly worse, that's fine.

Or if people are bored, and want something functional to test ... ;-) 
Fiddle with some of the new config options, eg turn on 4/4 split or 
2/2 split, or HZ=100, kgdb, kcg, schedstat, etc. Early printk is 
interesting too, but harder to test - you really need to make it
lock up before console_init somehow (adding a BUG() or something).

Thanks,

M.

