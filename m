Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbULTJoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbULTJoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbULTJoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:44:34 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:43119 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261417AbULTJoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:44:23 -0500
Message-ID: <41C69EF3.6010207@yahoo.com.au>
Date: Mon, 20 Dec 2004 20:44:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, Jens Axboe <axboe@suse.de>
Subject: Re: /sys/block vs. /sys/class/block
References: <1103526532.5320.33.camel@gaston>	 <41C68A6D.6060801@yahoo.com.au> <1103534958.14050.13.camel@gaston>
In-Reply-To: <1103534958.14050.13.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>Seems like that's where it belongs.
>>
>>The reason why it is in /sys/block is because it is apparently a "subsystem",
>>and using decl_subsys - drivers/block/genhd.c
> 
> 
> I'm not convinced ... If you look at how /sys is organized, it really
> doesn't make any sense ... block devives are really devices of "class
> block", wether we have a block "subsystem" in there is irrelevant imho.
> 

Sorry to be unclear: I was agreeing with you ;)

I was just pointing out that the reason it is currently /sys/block is
that decl_subsys call.

