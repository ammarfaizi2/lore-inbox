Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270880AbTGNVhD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270821AbTGNVdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:33:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56212 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270848AbTGNVbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:31:01 -0400
Message-ID: <3F132482.3090806@pobox.com>
Date: Mon, 14 Jul 2003 17:45:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: dsaxena@mvista.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
References: <Sea2-F18ekWo76UaiRN00008964@hotmail.com> <3F12FE4B.2070004@pobox.com> <20030714212222.GA21569@xanadu.az.mvista.com>
In-Reply-To: <20030714212222.GA21569@xanadu.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> My question back is how do you evaluate a high-end SCSI RAID controller
> to make sure that there is no bug in the firmware that causes you to loose 
> all your data? You test it and if it fails miserably, you go yell at the
> HW manufacturer. There's no argueing that the question needs to be answered 

Hardware RAID is not remotely accessible to the entire world.


> and OSDL?  I agree that TOE has problems and many of the points addressed 
> by others in this thread are valid concerns, but simply saying that
> because of these issues "TOE will never happen" or "TOE is Evil" is not 
> going to make the desire of TOE from HW vendors go away. There needs to 
> be an open discussion between HW vendors and the community to determine 
> the best way to move forward. This includes addressing questions such as
> do we want TOE + non-TOE stacks running at the same time? (I propose
> a big no for that since the level of complexity has just increased
> many times). Do we want to support multiple TOEs? How do we handle
> routing between TOEs? Etc... We either need to start thinking about

Answering those questions implies that TOE is a good idea.  That still 
is still an open question.

The community has been _trying_ to dialogue with people interested in a 
progressive solution that actually addresses the problems we raise.  I 
haven't seen a single response.

I don't see any dialogue at all.  The examples I have seen so far are HW 
vendors saying "we are doing TOE" not "should we be doing TOE?"

DaveM has been dropping ever-more-blatant hints about an efficient 
design.  Who has listened?


> these issues now or we'll be stuck with crap implementation requirements
> due to already existing TOE support in other OSes.  In a perfect academic 
> world TOE might be a horrid idea that should die, but the HW vendors have 
> already decided to move in this direction? How is linux going to react to 
> this: Just ignore it until it's too late or be pro-active about it?

Not all hardware vendors.  One specific hardware vendor, with decades of 
experience in TCP/IP and Unix, realizes that TOE is not the answer.


> A minimum step would be moving in the direction of FreeBSD and providing
> hooks for alternate stacks. That way if an embedded developer wanted
> to provide a different stack, he could do so and take full responsibility 
> for supporting that kernel.

This is trivial.  Just create your own character device driver and go to 
town.


> Finally, I would like to point out that just b/c something is considered
> bad does not preclude it from being in the kernel. I think most kernel
> developers agree that PAE, I2O, ISAPNP and other technologies are broken
> and we wish they would die, yet Linux still supports them. Why? B/C the
> HW requires it.  TOE is going to be no different. 

TOE is vastly different.

As Alan said, nobody is stopping developers from maintaining their own 
TOE fork of Linux.  Under Linux, forks are _encouraged_, remember.

	Jeff



