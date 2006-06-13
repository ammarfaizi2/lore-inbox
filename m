Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWFMWMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWFMWMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWFMWMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:12:36 -0400
Received: from palrel10.hp.com ([156.153.255.245]:41687 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932286AbWFMWMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:12:35 -0400
Message-ID: <448F384F.8050207@hp.com>
Date: Tue, 13 Jun 2006 15:12:31 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: David Miller <davem@davemloft.net>, jheffner@psc.edu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17: networking bug??
References: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>	<448F0344.9000008@rtr.ca>	<448F0D4B.30201@rtr.ca>	<20060613.142603.48825062.davem@davemloft.net> <448F32E1.8080002@rtr.ca>
In-Reply-To: <448F32E1.8080002@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

 From everything I have read so far (which admittedly hasn't been 
everything) it sounds like the firewall in question was a ticking 
timebomb.  If 2.6.17 hadn't set it off, something else might very well 
have done so.

Or, if you prefer another metaphore, 2.6.17 was simply the last in a 
series of straws on the back of the camel what was the firewall.  Meta 
issues of whether or not the camel that is firewalls should have ever 
been allowed to poke its nose in the Internet Tent notwithstanding :)

At the very least, the firewall, if it is going to be "stateless," has 
to strip the window scaling option from the SYN's that go past. 
Otherwise,  I would be inclined to agree with David that the firewall is 
fundamentally broken.

rick jones
